import 'package:weatherapp/models/zipcode.dart';
import 'package:weatherapp/repositries/openweather.dart';

/// A weather on a specific spot at specific time
class Weather {
  // Instances
  double? temperature;
  double? temperatureMax;
  double? temperatureMin;
  String? description;
  String? location;
  double? longitude;
  double? latitude;
  String? icon;
  DateTime? time;
  int? rainyPercent;

  /// Constructor
  Weather({
    this.temperature,
    this.temperatureMax,
    this.temperatureMin,
    this.description,
    this.location,
    this.longitude,
    this.latitude,
    this.icon,
    this.time,
    this.rainyPercent,
  });

  static Future<Weather?> getCurrentWeather(String zipCode) async {
    try {
      String zipCodeWithHyphen = ZipCode.getWithHyphen(zipCode);
      ZipCodeCoordinates? coordinate =
          await OpenWeatherApi.getCoordinateFromZipCode(zipCodeWithHyphen);
      if (coordinate == null) {
        return null;
      }

      WeatherData? weatherData =
          await OpenWeatherApi.getWeatherData(coordinate.lat, coordinate.lon);
      if (weatherData != null && weatherData.current != null) {
        return Weather(
          time: DateTime.fromMillisecondsSinceEpoch(
            (weatherData?.current?.dt ?? 0) + (weatherData?.timezoneOffset ?? 0),
            isUtc: true,
          ),
          temperature: weatherData?.current?.temp,
          rainyPercent: weatherData?.current?.clouds,
          icon: weatherData?.current?.weather[0].icon,
          description: weatherData?.current?.weather[0].description,
        );
      }

      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
