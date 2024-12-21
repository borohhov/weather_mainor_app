import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:weather_mainor_app/controller/persistence/weather_data_provider.dart';
import 'package:weather_mainor_app/views/today_weather_screen.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(ChangeNotifierProvider(
    create: (context) => WeatherDataProvider(),
    child: const MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TodayWeatherScreen(),
    );
  }
}


