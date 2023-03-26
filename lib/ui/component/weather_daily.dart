import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/models/weather.dart';

class DailyWeatherWidget extends StatelessWidget {
  final Weather weather;

  const DailyWeatherWidget({
    Key? key,
    required this.weather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            DateFormat('MM/DD(E)').format(weather.time ?? DateTime(0)),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(width: 10.0),
          Text(
            '${weather.icon}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(width: 10.0),
          Text(
            '${weather.rainyPercent}%',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(width: 10.0),
          Text(
            '${weather.temperatureMax}℃',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(width: 10.0),
          Text(
            '${weather.temperatureMin}℃',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
