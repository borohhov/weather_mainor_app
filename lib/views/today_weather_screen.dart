import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_mainor_app/controller/openai_controller.dart';
import 'package:weather_mainor_app/controller/persistence/weather_data_provider.dart';
import 'package:weather_mainor_app/models/openmeteo_response.dart';
import 'package:weather_mainor_app/models/weather_data.dart';
import 'package:weather_mainor_app/views/history_screen.dart';
import 'package:weather_mainor_app/views/weather_image.dart';

import '../controller/auth/auth_provider.dart';
import '../controller/openmeteo_api_call.dart';
import '../controller/utils.dart';
import '../controller/weather_condition_controller.dart';
import '../models/weather_data_log.dart';

class TodayWeatherScreen extends StatefulWidget {
  const TodayWeatherScreen({super.key});

  @override
  State<TodayWeatherScreen> createState() => _TodayWeatherScreenState();
}

class _TodayWeatherScreenState extends State<TodayWeatherScreen> {
  late Future<OpenMeteoResponse> _weatherFuture;

  @override
  void initState() {
    super.initState();
    _weatherFuture = fetchOpenMeteoWeather();
  }

  Future<void> onRefresh() async {
    // Refresh the weather data
    setState(() {
      _weatherFuture = fetchOpenMeteoWeather();
    });
    var response = await _weatherFuture; // Ensure the future is awaited
    final weatherData = WeatherData(
      'Tallinn',
      response.current.temperature2m,
      response.current.apparentTemperature,
      determineWeatherCondition(response),
    );
    String? uid = Provider.of<FirebaseAuthProvider>(context, listen: false).uid;
    WeatherDataLog log = WeatherDataLog(weatherData.location, "${weatherData.temperatureNow.toString()}°C",
        "${weatherData.feelsLikeTemperature.toString()}°C", getEmojiForCondition(weatherData.weatherCondition), uid
    );


    Provider.of<WeatherDataProvider>(context, listen: false).updateData(log);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => HistoryScreen()),
        );
      }, child: const Icon(Icons.history),),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: FutureBuilder<OpenMeteoResponse>(
          future: _weatherFuture,
          builder: (BuildContext context, AsyncSnapshot<OpenMeteoResponse> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Error fetching weather data.'));
            }
            if (snapshot.hasData) {
              final weatherData = WeatherData(
                'Tallinn',
                snapshot.data!.current.temperature2m,
                snapshot.data!.current.apparentTemperature,
                determineWeatherCondition(snapshot.data!),
              );

              return ListView(
                padding: EdgeInsets.only(top: 100),
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Tallinn',
                          style: TextStyle(fontSize: 30),
                        ),
                        Text(
                          "${weatherData.temperatureNow.toString()}°C",
                          style: const TextStyle(
                            fontSize: 75,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Feels like ${weatherData.feelsLikeTemperature.toString()}°C",
                          style: const TextStyle(fontSize: 24),
                        ),
                        WeatherEmojiWidget(condition: weatherData.weatherCondition),
                        const SizedBox(height: 20),
                        FutureBuilder<String>(
                          future: getWeatherRecommendation(weatherData.toString()),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            }
                            if (snapshot.hasData) {
                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  snapshot.data ?? "",
                                  style: const TextStyle(fontSize: 20),
                                ),
                              );
                            }
                            return Container();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return const Center(child: Text('Error fetching weather data.'));
          },
        ),
      ),
    );
  }
}
