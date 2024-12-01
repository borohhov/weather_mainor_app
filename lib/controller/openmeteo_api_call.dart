import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_mainor_app/controller/weather_condition_controller.dart';
import 'package:weather_mainor_app/models/weather_condition.dart';
import '../models/openmeteo_response.dart';


const String url = 'https://api.open-meteo.com/v1/forecast?latitude=59.437&longitude=24.7536&current=temperature_2m,relative_humidity_2m,apparent_temperature,precipitation,rain,showers,snowfall,cloud_cover,wind_speed_10m&timezone=auto&forecast_days=3';

Future<OpenMeteoResponse> fetchOpenMeteoWeather() async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    OpenMeteoResponse openMeteoResponse = OpenMeteoResponse.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    return openMeteoResponse;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to fetch weather');
  }
}