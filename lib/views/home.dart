import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weatherapp/models/weather.dart';
import 'package:weatherapp/models/zipcode.dart';
import 'package:weatherapp/repositries/openweather.dart';
import 'package:weatherapp/repositries/user_settings.dart';
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
  WeatherInformation? currentWeather;
  List<WeatherInformation> hourlyWeather = [];
  List<WeatherInformation> dailyWeather = [];
  final TextEditingController controller = TextEditingController();
  bool textIsValid = false;
  String? invalidZipCodeErrorMessage = 'Invalid Zip/Postal Code';

  Future updateZipCodeState(String zipCode) async {
    bool isValid = ZipCode.isValid(zipCode);
    String? errorMessage = isValid ? null : 'Invalid Zip/Postal Code';
    setState(() {
      textIsValid = isValid;
      invalidZipCodeErrorMessage = errorMessage;
    });
  }

  Future fetchAllWeatherInformation(String zipCode) async {
    bool isValid = ZipCode.isValid(zipCode);
    if (!isValid) {
      return;
    }

    print('SearchAddressFromZipCode');
    String zipCodeWithoutHyphen = ZipCode.getWithoutHyphen(zipCode);
    String? address =
        await ZipCodeApi.searchAddressFromZipCode(zipCodeWithoutHyphen);
    if (address == null) {
      String? errorMessage = 'No such location of this zip/postal Code.';
      setState(() {
        textIsValid = false;
        invalidZipCodeErrorMessage = errorMessage;
      });
      return;
    }

    UserSettings userSettings = await UserSettings.getInstance();
    userSettings.setZipCode(zipCodeWithoutHyphen);

    WeatherData? data = await WeatherInformation.getWeatherData(zipCode);
    if (data == null) {
      setState(() {
        textIsValid = false;
      });
      return;
    }

    WeatherForecast forecast = WeatherForecast.FromWeatherData(data);
    WeatherInformation? current = forecast.current;
    if (current != null) {
      setState(() {
        currentWeather = current;
        currentWeather?.location = address;
        hourlyWeather = forecast.hourly;
        dailyWeather = forecast.daily;
      });
    } else {
      setState(() {
        currentWeather = null;
        hourlyWeather = [];
        dailyWeather = [];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Future(() async {
      UserSettings userSettings = await UserSettings.getInstance();
      String? zipCode = userSettings.getZipCode();
      if (zipCode != null) {
        controller.text = zipCode;
        await updateZipCodeState(zipCode);
        await fetchAllWeatherInformation(zipCode);
      }
      setState(() {});
    });
  }

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
                  await updateZipCodeState(value);
                },
                onSubmitted: (value) async {
                  await fetchAllWeatherInformation(value);
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
