import 'package:flutter/material.dart';
import 'package:weatherapp/models/weather.dart';
import 'package:weatherapp/ui/component/weather_daily.dart';
import 'package:weatherapp/ui/component/weather_hourly.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Weather currentWeather = Weather(
    temperature: 10,
    description: '晴れ',
    temperatureMax: 20,
    temperatureMin: 5,
    location: '東京',
  );
  List<Weather> hourlyWeather = [
    Weather(
      temperature: 20,
      description: '晴れ',
      icon: '☀',
      rainyPercent: 0,
      time: DateTime(2023, 1, 2, 10),
    ),
    Weather(
      temperature: -5,
      description: '雪',
      icon: '☃',
      rainyPercent: 30,
      time: DateTime(2023, 1, 2, 11),
    ),
    Weather(
      temperature: 15,
      description: 'くもり',
      icon: '☁',
      rainyPercent: 50,
      time: DateTime(2023, 1, 2, 12),
    ),
    Weather(
      temperature: 30,
      description: '晴れ',
      icon: '☀',
      rainyPercent: 100,
      time: DateTime(2023, 1, 2, 13),
    ),
    Weather(
      temperature: 40,
      description: '晴れ',
      icon: '☀',
      rainyPercent: 100,
      time: DateTime(2023, 1, 2, 15),
    ),
    Weather(
      temperature: 40,
      description: '晴れ',
      icon: '☀',
      rainyPercent: 100,
      time: DateTime(2023, 1, 2, 15),
    ),
    Weather(
      temperature: 40,
      description: '晴れ',
      icon: '☀',
      rainyPercent: 100,
      time: DateTime(2023, 1, 2, 15),
    ),
    Weather(
      temperature: 40,
      description: '晴れ',
      icon: '☀',
      rainyPercent: 100,
      time: DateTime(2023, 1, 2, 15),
    ),
    Weather(
      temperature: 40,
      description: '晴れ',
      icon: '☀',
      rainyPercent: 100,
      time: DateTime(2023, 1, 2, 15),
    ),
    Weather(
      temperature: 40,
      description: '晴れ',
      icon: '☀',
      rainyPercent: 100,
      time: DateTime(2023, 1, 2, 15),
    ),
    Weather(
      temperature: 40,
      description: '晴れ',
      icon: '☀',
      rainyPercent: 100,
      time: DateTime(2023, 1, 2, 15),
    ),
    Weather(
      temperature: 40,
      description: '晴れ',
      icon: '☀',
      rainyPercent: 100,
      time: DateTime(2023, 1, 2, 15),
    ),
    Weather(
      temperature: 40,
      description: '晴れ',
      icon: '☀',
      rainyPercent: 100,
      time: DateTime(2023, 1, 2, 15),
    ),
  ];
  List<Weather> dailyWeather = [
    Weather(
      description: '晴れ',
      icon: '☀',
      rainyPercent: 0,
      time: DateTime(2023, 1, 2),
      temperatureMax: 30,
      temperatureMin: 20,
    ),
    Weather(
      description: 'くもり',
      icon: '☁',
      rainyPercent: 30,
      time: DateTime(2023, 1, 3),
      temperatureMax: 15,
      temperatureMin: 10,
    ),
    Weather(
      description: '雪',
      icon: '☃',
      rainyPercent: 100,
      time: DateTime(2023, 1, 4),
      temperatureMax: -10,
      temperatureMin: 5,
    ),
    Weather(
      description: '晴れ',
      icon: '☀',
      rainyPercent: 0,
      time: DateTime(2023, 1, 5),
      temperatureMax: 100,
      temperatureMin: 0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              // todo show current weather from API
              // todo show hourly weather forecast from API
              // todo show daily weather forecast from API
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50.0),
                  child: Column(children: <Widget>[
                    Text(
                      '${currentWeather.location}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '${currentWeather.description}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      '${currentWeather.temperature}℃',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Max:${currentWeather.temperatureMax}℃',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          'Min:${currentWeather.temperatureMin}℃',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
              const Divider(height: 0),
              SafeArea(
                child: Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: hourlyWeather
                            .map((w) => HourlyWeatherWidget(weather: w))
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(height: 0),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: dailyWeather
                          .map((w) => DailyWeatherWidget(weather: w))
                          .toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
