import 'package:hive_flutter/hive_flutter.dart';

class UserSettings {
  static const _hiveBoxName = 'WeatherAppUserSettingsBox';
  static const _hiveKeyZipCode = '_zipCode';
  final Box<Object> _box;

  UserSettings._(this._box);

  static Future<UserSettings> getInstance() async {
    final box = await Hive.openBox<Object>(_hiveBoxName);
    return UserSettings._(box);
  }

  String? getZipCode() {
    String? value = _getValueOrNull(_hiveKeyZipCode);
    print('get zipcode from usersetting: $value');
    return value;
  }

  Future<void> setZipCode(String zipCode) async {
    _setValue(_hiveKeyZipCode, zipCode);
    print('set zipcode to usersetting: $zipCode');
  }

  T? _getValueOrNull<T>(Object key) {
    return _box.get(key) as T?;
  }

  Future<void> _setValue(String key, Object value) async {
    return _box.put(key, value);
  }
}
