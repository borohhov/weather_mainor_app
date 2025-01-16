import 'package:weather_mainor_app/models/weather_data_log.dart';

abstract class Persistence {
  Future<void> init();
  Future<void> saveData(WeatherDataLog data);
  Future<List<WeatherDataLog>> getAllData();
}