import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/models/weather.dart';

class HourlyWeatherWidget extends StatelessWidget {
  final Weather weather;

  const HourlyWeatherWidget({
    Key? key,
    required this.weather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Text(
              DateFormat('HH:mm').format(weather.time ?? DateTime(0)),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              '☂ ${weather.rainyPercent}%',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              weather.icon ?? '☀',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              '${weather.temperature}℃',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ));
  }
}
