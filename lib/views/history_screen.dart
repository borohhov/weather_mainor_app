import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_mainor_app/controller/persistence/weather_data_provider.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Log"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: Provider.of<WeatherDataProvider>(context)
                .data
                .map((record) => Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "${record.location}: ${record.temperatureNow}, feels like ${record.feelsLikeTemperature}, ${record.weatherCondition}",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(record.savedTime),
                        Container(
                          height: 1,
                          color: const Color(0x330066FF),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                        )
                      ],
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
