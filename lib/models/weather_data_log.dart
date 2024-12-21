import 'package:intl/intl.dart';

class WeatherDataLog {
  String location;
  String temperatureNow;
  String feelsLikeTemperature;
  String weatherCondition;
  String savedTime = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());

  WeatherDataLog(this.location, this.temperatureNow, this.feelsLikeTemperature,
      this.weatherCondition);
}
