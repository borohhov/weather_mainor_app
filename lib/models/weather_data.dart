import 'package:weather_mainor_app/models/weather_condition.dart';

class WeatherData {
  String location;
  double temperatureNow;
  WeatherCondition weatherCondition;

  //List hourlyWeather; TODO we wanted to do this too
  String recommendation = "";

  WeatherData(this.location, this.temperatureNow, this.weatherCondition,
      {this.recommendation = "Wear your hat!"});
}
