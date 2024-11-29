import 'package:flutter/material.dart';
import 'package:weather_mainor_app/models/weather_condition.dart';
import 'package:weather_mainor_app/models/weather_data.dart';
import 'package:weather_mainor_app/views/weather_image.dart';

class TodayWeatherScreen extends StatefulWidget {
  const TodayWeatherScreen({super.key});

  @override
  State<TodayWeatherScreen> createState() => _TodayWeatherScreenState();
}

class _TodayWeatherScreenState extends State<TodayWeatherScreen> {
  WeatherData exampleWeatherData = WeatherData(
      "Tallinn", 4, WeatherCondition.hail,
      recommendation: "Don't forget your head!");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.only(top: 250),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                exampleWeatherData.location,
                style: TextStyle(fontSize: 30),
              ),
              Text(
                "${exampleWeatherData.temperatureNow.toString()}°C",
                style: TextStyle(fontSize: 75, fontWeight: FontWeight.bold),
              ),
              WeatherEmojiWidget(
                  condition: exampleWeatherData.weatherCondition),
              Container(
                padding: EdgeInsets.all(40),
              ),
              Text(
                "Recommendation: ${exampleWeatherData.recommendation}",
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
