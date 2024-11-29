import 'package:flutter/material.dart';

import '../models/weather_condition.dart';

class WeatherEmojiWidget extends StatelessWidget {
  final WeatherCondition condition;

  const WeatherEmojiWidget({Key? key, required this.condition}) : super(key: key);

  String _getEmojiForCondition(WeatherCondition condition) {
    switch (condition) {
      case WeatherCondition.sunny:
        return '☀️';
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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        _getEmojiForCondition(condition),
        style: const TextStyle(fontSize: 80), // Adjust the size as needed
      ),
    );
  }
}