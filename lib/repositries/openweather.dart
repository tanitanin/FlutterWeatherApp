import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class OpenWeatherApi {
  static String baseZipToGeoUri = 'http://api.openweathermap.org/geo/1.0/zip';
  static String baseOneCallUri =
      'https://api.openweathermap.org/data/3.0/onecall';
  static String baseIconUri = 'https://openweathermap.org/img/wn/';

  static Future<ZipCodeCoordinates?> getCoordinateFromZipCode(
      String zipCode) async {
    try {
      String apiKey = dotenv.get('OEPNWEATHER_API_KEY');
      String uri = '$baseZipToGeoUri?zip=$zipCode,JP&appid=$apiKey';

      print('Get coordinates (zipcode:$zipCode)');
      print(uri);
      var response = await get(Uri.parse(uri));
      if (response.statusCode != 200) {
        print('error: ${response.statusCode}');
        Map<String, dynamic> data = json.decode(response.body);
        if (data.isNotEmpty && data.containsKey('message')) {
          String message = data['message'];
          print('message: $message');
        }
        return null;
      }
      Map<String, dynamic> data = json.decode(response.body);
      print('response: ${response.body}');

      return ZipCodeCoordinates.fromJson(data);
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<WeatherData?> getWeatherData(
      double latitude, double longitude) async {
    try {
      String apiKey = dotenv.get('OEPNWEATHER_API_KEY');
      //String excludeParts = 'minutely,hourly,daily,alerts';
      String excludeParts = 'minutely,alerts';
      String uri =
          '$baseOneCallUri?lat=$latitude&lon=$longitude&exclude=$excludeParts&appid=$apiKey&lang=ja&units=metric';

      print('Get weather from coordinate(lat:$latitude,lon:$longitude)');
      print(uri);
      var response = await get(Uri.parse(uri));
      if (response.statusCode != 200) {
        print('error: ${response.statusCode}');
        Map<String, dynamic> data = json.decode(response.body);
        if (data.isNotEmpty && data.containsKey('message')) {
          String message = data['message'];
          print('message: $message');
        }
        return null;
      }

      Map<String, dynamic> data = json.decode(response.body);
      print('response: ${response.body}');

      return WeatherData.fromJson(data);
    } catch (e) {
      print(e);
      return null;
    }
  }

  static String getIconImageUri(String iconId) {
    String iconFileName = '$iconId.png';
    if (iconId.isEmpty) {
      iconFileName = '01d.png';
    }
    String uri = '$baseIconUri/$iconFileName';
    return uri;
  }
}

// Generated following codes by Chat-GPT

class ZipCodeCoordinates {
  final double lat;
  final double lon;

  ZipCodeCoordinates({required this.lat, required this.lon});

  factory ZipCodeCoordinates.fromJson(Map<String, dynamic> json) {
    return ZipCodeCoordinates(
      lat: json['lat'],
      lon: json['lon'],
    );
  }
}

class WeatherData {
  WeatherData({
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.timezoneOffset,
    required this.current,
    required this.hourly,
    required this.daily,
    required this.alerts,
  });

  double lat;
  double lon;
  String timezone;
  int timezoneOffset;
  Current? current;
  List<Hourly> hourly;
  List<Daily> daily;
  List<Alert> alerts;

  factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
        lat: json["lat"],
        //.toDouble(),
        lon: json["lon"],
        //.toDouble(),
        timezone: json["timezone"],
        timezoneOffset: json["timezone_offset"],
        current: json.containsKey("current")
            ? Current.fromJson(json["current"])
            : null,
        hourly: json.containsKey("hourly")
            ? List<Hourly>.from(json["hourly"].map((x) => Hourly.fromJson(x)))
            : <Hourly>[],
        daily: json.containsKey("daily")
            ? List<Daily>.from(json["daily"].map((x) => Daily.fromJson(x)))
            : <Daily>[],
        alerts: json.containsKey("alerts")
            ? List<Alert>.from(json["alerts"].map((x) => Alert.fromJson(x)))
            : <Alert>[],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
        "timezone": timezone,
        "timezone_offset": timezoneOffset,
        "current": current?.toJson() ?? '',
        "hourly": List<dynamic>.from(hourly.map((x) => x.toJson())),
        "daily": List<dynamic>.from(daily.map((x) => x.toJson())),
        "alerts": List<dynamic>.from(alerts.map((x) => x.toJson())),
      };
}

class Alert {
  Alert({
    required this.senderName,
    required this.event,
    required this.start,
    required this.end,
    required this.description,
  });

  String senderName;
  String event;
  int start;
  int end;
  String description;

  factory Alert.fromJson(Map<String, dynamic> json) => Alert(
        senderName: json["sender_name"],
        event: json["event"],
        start: json["start"],
        end: json["end"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "sender_name": senderName,
        "event": event,
        "start": start,
        "end": end,
        "description": description,
      };
}

class Current {
  Current({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.uvi,
    required this.clouds,
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    required this.weather,
  });

  int dt;
  int sunrise;
  int sunset;
  double temp;
  double feelsLike;
  int pressure;
  int humidity;
  double dewPoint;
  double uvi;
  int clouds;
  int visibility;
  double windSpeed;
  int windDeg;
  List<Weather> weather;

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        dt: json["dt"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
        temp: json["temp"].toDouble(),
        feelsLike: json["feels_like"].toDouble(),
        pressure: json["pressure"],
        humidity: json["humidity"],
        dewPoint: json["dew_point"].toDouble(),
        uvi: json["uvi"].toDouble(),
        clouds: json["clouds"],
        visibility: json["visibility"],
        windSpeed: json["wind_speed"].toDouble(),
        windDeg: json["wind_deg"],
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "dt": dt,
        "sunrise": sunrise,
        "sunset": sunset,
        "temp": temp,
        "feels_like": feelsLike,
        "pressure": pressure,
        "humidity": humidity,
        "dew_point": dewPoint,
        "uvi": uvi,
        "clouds": clouds,
        "visibility": visibility,
        "wind_speed": windSpeed,
        "wind_deg": windDeg,
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
      };
}

class Weather {
  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  int id;
  String main;
  String description;
  String icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
      };
}

class Daily {
  Daily({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.windSpeed,
    required this.windDeg,
    required this.weather,
    required this.clouds,
    required this.pop,
    required this.rain,
    required this.snow,
    required this.uvi,
  });

  int dt;
  int sunrise;
  int sunset;
  Temp temp;
  FeelsLike feelsLike;
  int pressure;
  int humidity;
  double dewPoint;
  double windSpeed;
  int windDeg;
  List<Weather> weather;
  int clouds;
  double pop;
  double? rain;
  double? snow;
  double uvi;

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
        dt: json["dt"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
        temp: Temp.fromJson(json["temp"]),
        feelsLike: FeelsLike.fromJson(json["feels_like"]),
        pressure: json["pressure"],
        humidity: json["humidity"],
        dewPoint: json["dew_point"].toDouble(),
        windSpeed: json["wind_speed"].toDouble(),
        windDeg: json["wind_deg"],
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        clouds: json["clouds"],
        pop: json["pop"].toDouble(),
        rain: json["rain"]?.toDouble(),
        snow: json["snow"]?.toDouble(),
        uvi: json["uvi"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "dt": dt,
        "sunrise": sunrise,
        "sunset": sunset,
        "temp": temp.toJson(),
        "feels_like": feelsLike.toJson(),
        "pressure": pressure,
        "humidity": humidity,
        "dew_point": dewPoint,
        "wind_speed": windSpeed,
        "wind_deg": windDeg,
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "clouds": clouds,
        "pop": pop,
        "rain": rain,
        "uvi": uvi,
      };
}

class FeelsLike {
  FeelsLike({
    required this.day,
    required this.night,
    required this.eve,
    required this.morn,
  });

  double day;
  double night;
  double eve;
  double morn;

  factory FeelsLike.fromJson(Map<String, dynamic> json) => FeelsLike(
        day: json["day"].toDouble(),
        night: json["night"].toDouble(),
        eve: json["eve"].toDouble(),
        morn: json["morn"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "night": night,
        "eve": eve,
        "morn": morn,
      };
}

class Temp {
  Temp({
    required this.day,
    required this.min,
    required this.max,
    required this.night,
    required this.eve,
    required this.morn,
  });

  double day;
  double min;
  double max;
  double night;
  double eve;
  double morn;

  factory Temp.fromJson(Map<String, dynamic> json) => Temp(
        day: json["day"].toDouble(),
        min: json["min"].toDouble(),
        max: json["max"].toDouble(),
        night: json["night"].toDouble(),
        eve: json["eve"].toDouble(),
        morn: json["morn"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "min": min,
        "max": max,
        "night": night,
        "eve": eve,
        "morn": morn,
      };
}

class Hourly {
  Hourly({
    required this.dt,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.uvi,
    required this.clouds,
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.weather,
    required this.pop,
    required this.rain,
  });

  int dt;
  double temp;
  double feelsLike;
  int pressure;
  int humidity;
  double dewPoint;
  double uvi;
  int clouds;
  int visibility;
  double windSpeed;
  int windDeg;
  double? windGust;
  List<Weather> weather;
  double? pop;
  Rain? rain;

  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
        dt: json["dt"],
        temp: json["temp"].toDouble(),
        feelsLike: json["feels_like"].toDouble(),
        pressure: json["pressure"],
        humidity: json["humidity"],
        dewPoint: json["dew_point"].toDouble(),
        uvi: json["uvi"].toDouble(),
        clouds: json["clouds"],
        visibility: json["visibility"],
        windSpeed: json["wind_speed"].toDouble(),
        windDeg: json["wind_deg"],
        windGust:
            json["wind_gust"] != null ? json["wind_gust"].toDouble() : null,
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        pop: json["pop"] != null ? json["pop"].toDouble() : null,
        rain: json["rain"] != null ? Rain.fromJson(json["rain"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "dt": dt,
        "temp": temp,
        "feels_like": feelsLike,
        "pressure": pressure,
        "humidity": humidity,
        "dew_point": dewPoint,
        "uvi": uvi,
        "clouds": clouds,
        "visibility": visibility,
        "wind_speed": windSpeed,
        "wind_deg": windDeg,
        "wind_gust": windGust,
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "pop": pop,
        "rain": rain?.toJson(),
      };
}

class Rain {
  Rain({
    required this.the1H,
  });

  double the1H;

  factory Rain.fromJson(Map<String, dynamic> json) => Rain(
        the1H: json["1h"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "1h": the1H,
      };
}
