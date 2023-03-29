import 'dart:ui';

import 'package:weatherapp/models/zipcode.dart';
import 'package:weatherapp/repositries/openweather.dart';
import 'package:weatherapp/utilities/datetime_extension.dart';

/// A weather on a specific spot at specific time
class WeatherInformation {
  // Instances
  double? temperature;
  double? temperatureMax;
  double? temperatureMin;
  String? description;
  String? location;
  double? longitude;
  double? latitude;
  String? iconUri;
  DateTime? time;
  int? rainyPercent;

  /// Constructor
  WeatherInformation({
    this.temperature,
    this.temperatureMax,
    this.temperatureMin,
    this.description,
    this.location,
    this.longitude,
    this.latitude,
    this.iconUri,
    this.time,
    this.rainyPercent,
  });

  static Future<WeatherData?> getWeatherData(String zipCode) async {
    try {
      String zipCodeWithHyphen = ZipCode.getWithHyphen(zipCode);
      ZipCodeCoordinates? coordinate =
          await OpenWeatherApi.getCoordinateFromZipCode(zipCodeWithHyphen);
      if (coordinate == null) {
        return null;
      }

      WeatherData? weatherData =
          await OpenWeatherApi.getWeatherData(coordinate.lat, coordinate.lon);
      return weatherData;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<WeatherInformation?> getCurrentWeather(String zipCode) async {
    try {
      WeatherData? weatherData =
          await WeatherInformation.getWeatherData(zipCode);
      if (weatherData != null && weatherData.current != null) {
        return WeatherInformation(
          time: DateTime.fromMillisecondsSinceEpoch(
            (weatherData.current?.dt ?? 0) + (weatherData.timezoneOffset ?? 0),
            isUtc: true,
          ),
          temperature: weatherData.current?.temp,
          rainyPercent: weatherData.current?.clouds,
          iconUri: OpenWeatherApi.getIconImageUri(
              weatherData.current?.weather[0].icon ?? ''),
          description: weatherData.current?.weather[0].description,
        );
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static WeatherInformation? CurrentFromWeatherData(WeatherData data) {
    if (data.current == null) {
      return null;
    }
    final Current currentData = data.current!;
    final DateTime currentTime = currentData.dt.toDateTimeAsUnixTimestamp();
    Daily dailyData = data.daily.firstWhere((element) =>
        element.dt.toDateTimeAsUnixTimestamp().isSameDate(currentTime));
    return WeatherInformation(
      time: currentTime,
      temperature: currentData.temp,
      temperatureMax: dailyData.temp.max,
      temperatureMin: dailyData.temp.min,
      rainyPercent: currentData.clouds,
      iconUri: currentData.weather[0].icon,
      description: currentData.weather[0].description,
    );
  }

  static List<WeatherInformation> HourlyFromWeatherData(WeatherData data) {
    if (data.hourly == null || data.hourly.isEmpty) {
      return [];
    }

    return data.hourly
        .map((e) => WeatherInformation(
              time: e.dt.toDateTimeAsUnixTimestamp(),
              temperature: e.temp,
              rainyPercent: e.clouds,
              description: e.weather[0].main,
              iconUri: e.weather[0].icon,
            ))
        .toList();
  }

  static List<WeatherInformation> DailyFromWeatherData(WeatherData data) {
    if (data.daily == null || data.daily.isEmpty) {
      return [];
    }

    return data.daily
        .map((e) => WeatherInformation(
              time: e.dt.toDateTimeAsUnixTimestamp(),
              temperatureMax: e.temp.max,
              temperatureMin: e.temp.min,
              rainyPercent: e.clouds,
              description: e.weather[0].main,
              iconUri: e.weather[0].icon,
            ))
        .toList();
  }
}

class WeatherForecast {
  WeatherInformation? current;
  List<WeatherInformation> hourly;
  List<WeatherInformation> daily;

  WeatherForecast({
    required this.current,
    required this.hourly,
    required this.daily,
  });

  static WeatherForecast FromWeatherData(WeatherData data) {
    return WeatherForecast(
      current: WeatherInformation.CurrentFromWeatherData(data),
      hourly: WeatherInformation.HourlyFromWeatherData(data),
      daily: WeatherInformation.DailyFromWeatherData(data),
    );
  }
}
