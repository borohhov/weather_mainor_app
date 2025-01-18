import 'dart:collection';

import 'package:intl/intl.dart';

class WeatherDataLog {
  String location;
  String temperatureNow;
  String feelsLikeTemperature;
  String weatherCondition;
  String savedTime = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
  String? author;

  WeatherDataLog(this.location, this.temperatureNow, this.feelsLikeTemperature,
      this.weatherCondition, this.author);

  Map<String, dynamic> toJson() {
    HashMap<String, dynamic> map = HashMap();
    map['location'] = this.location;
    map['temperatureNow'] = this.temperatureNow;
    map['feelsLikeTemperature'] = this.feelsLikeTemperature;
    map['weatherCondition'] = this.weatherCondition;
    map['savedTime'] = savedTime;
    map['author'] = author;
    return map;
  }

  WeatherDataLog.fromJson(Map<dynamic, dynamic> json)
      : location = json['location'],
        temperatureNow = json['temperatureNow'],
        feelsLikeTemperature = json['feelsLikeTemperature'],
        weatherCondition = json['weatherCondition'],
        savedTime = json['savedTime'],
        author = json['author'];
}
