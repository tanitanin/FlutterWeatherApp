import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/models/weather.dart';
import 'package:weatherapp/repositries/openweather.dart';

class DailyWeatherWidget extends StatelessWidget {
  final WeatherInformation weather;

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
            DateFormat('MM/dd(E)').format(weather.time ?? DateTime(0)),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(width: 10.0),
          (weather.iconUri != null)
              ? SizedBox(
                  height: 32,
                  child: Image.network(
                      OpenWeatherApi.getIconImageUri(weather.iconUri!)),
                )
              : Text(
                  '☀',
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
