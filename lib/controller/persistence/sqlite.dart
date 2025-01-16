import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../models/weather_data_log.dart';
import 'persistence.dart';        // Your abstract interface

class SqlLite implements Persistence {
  // Singleton boilerplate
  static final SqlLite _instance = SqlLite._internal();
  factory SqlLite() => _instance;
  SqlLite._internal();

  Database? _db;

  /// Initialize the database once. Avoid exposing the
  /// SQLite details in multiple places.
  @override
  Future<void> init() async {
    // If _db is already initialized, skip
    if (_db != null) return;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'weather_data.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE WeatherDataLog (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            location TEXT,
            temperatureNow TEXT,
            feelsLikeTemperature TEXT,
            weatherCondition TEXT,
            savedTime TEXT
          )
        ''');
      },
    );
  }

  /// Persists a [WeatherDataLog] entry into the database.
  @override
  Future<void> saveData(WeatherDataLog data) async {
    if (_db == null) {
      throw Exception('Database not initialized. Call init() first.');
    }

    await _db!.insert(
      'WeatherDataLog',
      {
        'location': data.location,
        'temperatureNow': data.temperatureNow,
        'feelsLikeTemperature': data.feelsLikeTemperature,
        'weatherCondition': data.weatherCondition,
        'savedTime': data.savedTime, // e.g. '2025-01-16 14:23'
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Retrieves all rows from the WeatherDataLog table
  /// and maps them to [WeatherDataLog] instances.
  @override
  Future<List<WeatherDataLog>> getAllData() async {
    if (_db == null) {
      throw Exception('Database not initialized. Call init() first.');
    }

    final List<Map<String, dynamic>> result =
    await _db!.query('WeatherDataLog');

    return List.generate(result.length, (i) {
      final row = result[i];
      final dataLog = WeatherDataLog(
        row['location'],
        row['temperatureNow'],
        row['feelsLikeTemperature'],
        row['weatherCondition'],
      );
      dataLog.savedTime = row['savedTime'];
      return dataLog;
    });
  }
}
