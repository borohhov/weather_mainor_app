import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:weather_mainor_app/controller/openai_controller.dart';
import 'package:weather_mainor_app/models/openmeteo_response.dart';
import 'package:weather_mainor_app/models/weather_condition.dart';
import 'package:weather_mainor_app/models/weather_data.dart';
import 'package:weather_mainor_app/views/weather_image.dart';

import '../controller/openmeteo_api_call.dart';
import '../controller/weather_condition_controller.dart';

class TodayWeatherScreen extends StatefulWidget {
  const TodayWeatherScreen({super.key});

  @override
  State<TodayWeatherScreen> createState() => _TodayWeatherScreenState();
}

class _TodayWeatherScreenState extends State<TodayWeatherScreen> {
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
                'Tallinn',
                style: TextStyle(fontSize: 30),
              ),
              FutureBuilder(future: fetchOpenMeteoWeather(),
                  builder: (BuildContext context,
                      AsyncSnapshot<OpenMeteoResponse> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text('Loading...');
                    }
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      WeatherData weatherData = WeatherData(
                          'Tallinn', snapshot.data!.current.temperature2m,
                          snapshot.data!.current.apparentTemperature,
                          determineWeatherCondition(snapshot.data!));
                      return Column(children: [
                        Text(
                        "${weatherData.temperatureNow.toString()}°C",
                        style: const TextStyle(fontSize: 75,
                            fontWeight: FontWeight.bold),
                      ),
                        Text(
                          "Feels like ${weatherData.feelsLikeTemperature.toString()}°C",
                          style: const TextStyle(fontSize: 24),
                        ),
                        WeatherEmojiWidget(
                            condition: weatherData.weatherCondition),
                        Container(
                          padding: EdgeInsets.all(40),
                        ),
                        FutureBuilder<String>(
                          future: getWeatherRecommendation(weatherData.toString()),
                          builder: (context, snapshot) {
                            if(snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  snapshot.data ?? "",
                                  style: TextStyle(fontSize: 20),
                                ),
                              );
                            }
                            return Container();

                          }
                        )
                      ],);
                    }
                    return const Text('Error!');
                  }),

            ],
          ),
        ),
      ),
    );
  }
}
