import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:weather_mainor_app/controller/auth/auth_provider.dart';
import 'package:weather_mainor_app/controller/persistence/weather_data_provider.dart';
import 'package:weather_mainor_app/views/today_weather_screen.dart';

import 'firebase_options.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => WeatherDataProvider(),
      ),
      ChangeNotifierProvider(create: (context) => FirebaseAuthProvider())
    ], child: const MyApp(),),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<FirebaseAuthProvider>(context, listen: false).init();
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
