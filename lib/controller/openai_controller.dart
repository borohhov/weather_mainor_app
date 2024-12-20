import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
Future<String> getWeatherRecommendation(String weatherData) async {


  final apiKey = dotenv.env['OPENAI_API_KEY'];
  final url = Uri.parse('https://api.openai.com/v1/chat/completions');

  final requestBody = jsonEncode({
    "model": "gpt-4o-mini",
    "messages": [
      {
        "role": "system",
        "content": "You are a helpful assistant providing weather-based clothing recommendations. Please be brief, no more than 1 sentence."
      },
      {
        "role": "user",
        "content":
        "Based on this weather data: $weatherData, what should I wear or take with me?"
      }
    ],
    "temperature": 0.7,
  });

  final response = await HttpClient()
      .postUrl(url)
      .then((HttpClientRequest request) {
    request.headers.add(HttpHeaders.contentTypeHeader, "application/json");
    request.headers.add(HttpHeaders.authorizationHeader, 'Bearer $apiKey');
    request.add(utf8.encode(requestBody));
    return request.close();
  });

  final responseData = await response.transform(utf8.decoder).join();
  final jsonResponse = jsonDecode(responseData);
  if (response.statusCode == 200) {
    final recommendation = jsonResponse['choices'][0]['message']['content'];
    return recommendation;
  } else {
    return "Can't recommend anything now.";
  }
}