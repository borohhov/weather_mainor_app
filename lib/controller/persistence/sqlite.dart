import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../models/weather_data_log.dart';
import 'persistence.dart';

class SqlLiteController implements Persistence {
  static final SqlLiteController _instance = SqlLiteController._internal();
  factory SqlLiteController() => _instance;
  SqlLiteController._internal();

  Database? _db;
  @override
  Future<void> init() async {
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
        'savedTime': data.savedTime,
        'author': data.author
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<WeatherDataLog>> getAllData() async {
    if (_db == null) {
      throw Exception('Database not initialized. Call init() first.');
    }

    final List<Map<String, dynamic>> result =
    await _db!.query('WeatherDataLog');
// select * from WeatherDataLog
    return List.generate(result.length, (i) {
      final row = result[i];
      final dataLog = WeatherDataLog(
        row['location'],
        row['temperatureNow'],
        row['feelsLikeTemperature'],
        row['weatherCondition'],
        row['author']
      );
      dataLog.savedTime = row['savedTime'];
      return dataLog;
    });
  }
}
