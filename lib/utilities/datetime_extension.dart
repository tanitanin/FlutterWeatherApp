extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

extension UnixTimestampConversion on int {
  DateTime toDateTimeAsUnixTimestamp({bool isUtc = false}) {
    return DateTime.fromMillisecondsSinceEpoch(this * 1000, isUtc: isUtc);
  }
}
