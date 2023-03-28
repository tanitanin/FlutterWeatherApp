import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weatherapp/repositries/user_settings.dart';
import 'app.dart';

Future main() async {
  await dotenv.load(fileName: '.env');
  await Hive.initFlutter();
  runApp(const MyApp());
}
