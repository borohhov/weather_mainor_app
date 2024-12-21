import 'package:flutter/material.dart';
import 'package:weather_mainor_app/controller/utils.dart';

import '../models/weather_condition.dart';

class WeatherEmojiWidget extends StatelessWidget {
  final WeatherCondition condition;

  const WeatherEmojiWidget({Key? key, required this.condition}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        getEmojiForCondition(condition),
        style: const TextStyle(fontSize: 80), // Adjust the size as needed
      ),
    );
  }
}