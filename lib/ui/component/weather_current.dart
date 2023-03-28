import 'package:flutter/material.dart';
import 'package:weatherapp/models/weather.dart';

class CurrentWeatherWidget extends StatelessWidget {
  final WeatherInformation? weather;

  const CurrentWeatherWidget({
    Key? key,
    required this.weather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Column(children: <Widget>[
        Text(
          weather?.location ?? '-',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          weather?.description ?? '-',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          '${weather?.temperature ?? '-'}℃',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Max:${weather?.temperatureMax ?? '-'}℃',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              'Min:${weather?.temperatureMin ?? '-'}℃',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ]),
    );
  }
}
