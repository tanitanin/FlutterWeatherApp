import 'package:flutter/material.dart';
import 'package:weatherapp/models/weather.dart';
import 'package:weatherapp/models/zipcode.dart';
import 'package:weatherapp/repositries/zipcloud.dart';
import 'package:weatherapp/ui/component/weather_current.dart';
import 'package:weatherapp/ui/component/weather_daily.dart';
import 'package:weatherapp/ui/component/weather_hourly.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Weather? currentWeather;
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
  final TextEditingController controller = TextEditingController();
  bool textIsValid = false;
  String? invalidZipCodeErrorMessage = 'Invalid Zip/Postal Code';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // todo show current weather from API
            // todo show hourly weather forecast from API
            // todo show daily weather forecast from API
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                maxLength: 8,
                decoration: InputDecoration(
                  labelText: 'Zip/Postal Code',
                  hintText: 'Input Zip/Postal Code',
                  errorText: (textIsValid ? null : invalidZipCodeErrorMessage),
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) async {
                  bool isValid = ZipCode.isValid(value);
                  String? errorMessage =
                      isValid ? null : 'Invalid Zip/Postal Code';
                  setState(() {
                    textIsValid = isValid;
                    invalidZipCodeErrorMessage = errorMessage;
                  });
                },
                onSubmitted: (value) async {
                  bool isValid = ZipCode.isValid(value);
                  if (isValid) {
                    print('SearchAddressFromZipCode');
                    String zipCode = ZipCode.getWithoutHyphen(value);
                    String? address =
                        await ZipCodeApi.searchAddressFromZipCode(zipCode);
                    if (address == null) {
                      String? errorMessage =
                          'No such location of this zip/postal Code.';
                      setState(() {
                        textIsValid = false;
                        invalidZipCodeErrorMessage = errorMessage;
                      });
                    } else {
                      setState(() {
                        textIsValid = true;
                      });
                      Weather? current =
                          await Weather.getCurrentWeather(zipCode);
                      if (current != null) {
                        setState(() {
                          currentWeather = current;
                          currentWeather?.location = address;
                        });
                      } else {
                        setState(() {
                          currentWeather = null;
                        });
                      }
                    }
                  }
                },
              ),
            ),
            CurrentWeatherWidget(weather: currentWeather),
            const Divider(height: 0),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                children: hourlyWeather
                    .map((w) => HourlyWeatherWidget(weather: w))
                    .toList(),
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
    );
  }
}
