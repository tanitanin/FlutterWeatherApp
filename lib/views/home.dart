import 'package:flutter/material.dart';
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
            // todo show current weather
            // todo show hourly weather forecast
            // todo show daily weather forecast
            SafeArea(
                child: Column(
                  children: [
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
                          '最高:${currentWeather.temperatureMax}℃',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          '最低:${currentWeather.temperatureMin}℃',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    )
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
