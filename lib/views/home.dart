import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/models/weather.dart';

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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // todo show hourly weather forecast
            // todo show daily weather forecast
            // todo show current weather from API
            // todo show hourly weather forecast from API
            // todo show daily weather forecast from API
            SafeArea(
              child: Column(
                children:[
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
                  SizedBox(height: 20),
                  Divider(height: 0),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: hourlyWeather.map((w) =>
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          children: [
                            Text(
                              '${DateFormat('HH:mm').format(w.time ?? DateTime(0))}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              '☂ ${w.rainyPercent}%',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(
                              '${w.icon ?? '☀'}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              '${w.temperature}℃',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        )
                      )
                    ).toList(),
                  ),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
