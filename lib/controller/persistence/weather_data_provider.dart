import 'package:flutter/material.dart';
import 'package:weather_mainor_app/models/weather_data.dart';
import 'package:weather_mainor_app/models/weather_data_log.dart';

class WeatherDataProvider extends ChangeNotifier {
  List<WeatherDataLog> logs = [];

  List<WeatherDataLog> get data => logs;

  void updateData(WeatherData newData) {
    logs.add(WeatherDataLog(newData.location, "${newData.temperatureNow.toString()}°C",
      "${newData.feelsLikeTemperature.toString()}°C", newData.weatherCondition.toString()));
    notifyListeners();
  }
}
