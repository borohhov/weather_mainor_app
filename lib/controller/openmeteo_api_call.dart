import 'package:http/http.dart' as http;


const String url = 'https://api.open-meteo.com/v1/forecast?latitude=59.437&longitude=24.7536&current=temperature_2m,relative_humidity_2m,apparent_temperature,precipitation,rain,showers,snowfall,cloud_cover,wind_speed_10m&timezone=auto&forecast_days=3';
Future<http.Response> fetchOpenMeteoWeather() {
  return http.get(Uri.parse(url));
}