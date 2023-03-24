
/// A weather on a specific spot at specific time
class Weather {

  // Instances
  int? temperature;
  int? temperatureMax;
  int? temperatureMin;
  String? description;
  String? location;
  double? longitude;
  double? latitude;
  String? iconPath;
  DateTime? time;
  int? rainyPercent;

  /// Constructor
  Weather({
    this.temperature, this.temperatureMax, this.temperatureMin, this.description,
    this.location, this.longitude, this.latitude,
    this.iconPath, this.time, this.rainyPercent,
  });
}
