import 'package:weather_mainor_app/models/weather_condition.dart';

String getEmojiForCondition(WeatherCondition condition) {
  switch (condition) {
    case WeatherCondition.sunny:
      return '☀️';
    case WeatherCondition.still:
      return '✨';
    case WeatherCondition.sunWithClouds:
      return '⛅';
    case WeatherCondition.cloudy:
      return '☁️';
    case WeatherCondition.rainy:
      return '🌧️';
    case WeatherCondition.snowy:
      return '❄️';
    case WeatherCondition.thunderstorm:
      return '⛈️';
    case WeatherCondition.windy:
      return '🌬️';
    case WeatherCondition.foggy:
      return '🌫️';
    case WeatherCondition.drizzle:
      return '🌦️';
    case WeatherCondition.hail:
      return '🌨️';
    case WeatherCondition.tornado:
      return '🌪️';
    case WeatherCondition.hurricane:
      return '🌀';
    case WeatherCondition.unknown:
    default:
      return '❓';
  }
}