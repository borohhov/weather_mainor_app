class OpenMeteoResponse {
  final double latitude;
  final double longitude;
  final String timezone;
  final String timezoneAbbreviation;
  final double elevation;
  final CurrentWeather current;

  OpenMeteoResponse({
    required this.latitude,
    required this.longitude,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.elevation,
    required this.current,
  });

  factory OpenMeteoResponse.fromJson(Map<String, dynamic> json) {
    return OpenMeteoResponse(
      latitude: json['latitude'],
      longitude: json['longitude'],
      timezone: json['timezone'],
      timezoneAbbreviation: json['timezone_abbreviation'],
      elevation: json['elevation'],
      current: CurrentWeather.fromJson(json['current']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'timezone': timezone,
      'timezone_abbreviation': timezoneAbbreviation,
      'elevation': elevation,
      'current': current.toJson(),
    };
  }
}

class CurrentWeather {
  final String time;
  final int interval;
  final double temperature2m;
  final int relativeHumidity2m;
  final double apparentTemperature;
  final double precipitation;
  final double rain;
  final double showers;
  final double snowfall;
  final int cloudCover;
  final double windSpeed10m;

  CurrentWeather({
    required this.time,
    required this.interval,
    required this.temperature2m,
    required this.relativeHumidity2m,
    required this.apparentTemperature,
    required this.precipitation,
    required this.rain,
    required this.showers,
    required this.snowfall,
    required this.cloudCover,
    required this.windSpeed10m,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      time: json['time'],
      interval: json['interval'],
      temperature2m: json['temperature_2m'],
      relativeHumidity2m: json['relative_humidity_2m'],
      apparentTemperature: json['apparent_temperature'],
      precipitation: json['precipitation'],
      rain: json['rain'],
      showers: json['showers'],
      snowfall: json['snowfall'],
      cloudCover: json['cloud_cover'],
      windSpeed10m: json['wind_speed_10m'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'interval': interval,
      'temperature_2m': temperature2m,
      'relative_humidity_2m': relativeHumidity2m,
      'apparent_temperature': apparentTemperature,
      'precipitation': precipitation,
      'rain': rain,
      'showers': showers,
      'snowfall': snowfall,
      'cloud_cover': cloudCover,
      'wind_speed_10m': windSpeed10m,
    };
  }
}
