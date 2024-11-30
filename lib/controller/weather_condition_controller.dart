import '../models/openmeteo_response.dart';
import '../models/weather_condition.dart';

WeatherCondition determineWeatherCondition(OpenMeteoResponse response) {
  final current = response.current;

  if (current.snowfall > 0) {
    return WeatherCondition.snowy;
  } else if (current.precipitation > 0) {
    if (current.precipitation >= 80 && current.windSpeed10m > 100) {
      return WeatherCondition.hurricane; // Adjust threshold as necessary
    } else if (current.precipitation >= 50 && current.windSpeed10m > 50) {
      return WeatherCondition.thunderstorm;
    } else {
      return WeatherCondition.rainy;
    }
  } else if (current.cloudCover >= 75) {
    return WeatherCondition.cloudy;
  } else if (current.cloudCover >= 25) {
    return WeatherCondition.sunWithClouds;
  } else if (current.windSpeed10m > 30) {
    // Adjust wind speed threshold as needed
    return WeatherCondition.windy;
  } else if (response.elevation < 100 && current.relativeHumidity2m > 95) {
    return WeatherCondition.foggy;
  } else if (response.timezoneAbbreviation == "EET" &&
      current.time.contains("T")) {
    DateTime currentTime = DateTime.parse(current.time);
    if (currentTime.hour >= 20 || currentTime.hour <= 5) {
      return WeatherCondition.still;
    } else {
      return WeatherCondition.sunny;
    }
  } else {
    return WeatherCondition.unknown;
  }
}
