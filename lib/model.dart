import 'package:intl/intl.dart';

//  data from AccuWeather

class location {
  late String name;

  location({
    required this.name,
  });
  factory location.fromJson(Map<String, dynamic> json) {
    return location(name: json['LocalizedName']);
  }
}

class currentWeather {
  late String WeatherText;
  late String Temperature;
  late String windSpeed;
  late String windDirection;
  late String dateTime;
  late String visibility;
  late String humidity;
  late String pressure;
  late String weekday;

  currentWeather({
    required this.WeatherText,
    required this.Temperature,
    required this.windSpeed,
    required this.windDirection,
    required this.dateTime,
    required this.weekday,
    required this.humidity,
    required this.visibility,
    required this.pressure,
  });
  factory currentWeather.fromJson(Map<String, dynamic> json) {
    return currentWeather(
      WeatherText: json['WeatherText'],
      Temperature: json['Temperature']['Metric']['Value'].toString(),
      windSpeed: json['Wind']['Speed']['Metric']['Value'].toString(),
      windDirection: json['Wind']['Direction']['Localized'].toString(),
      dateTime: accuDateFormat(json['LocalObservationDateTime'].toString()),
      visibility: json['Visibility']['Metric']['Value'].toString(),
      humidity: json['RelativeHumidity'].toString(),
      pressure: json['Pressure']['Metric']['Value'].toString(),
      weekday: accuDayFormat(json['LocalObservationDateTime'].toString()),
    );
  }
}

class Weather {
  late String weekday;
  late String date;
  late String tempMin;
  late String tempMax;
  late String day;
  late String windSpeed;
  late String windDirection;

  Weather({
    required this.weekday,
    required this.date,
    required this.tempMin,
    required this.tempMax,
    required this.day,
    required this.windSpeed,
    required this.windDirection,
  });
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      weekday: accuDayFormat(json['Date'].toString()),
      date: accuDateFormat(json['Date'].toString()),
      // date: json['Date'].toString(),
      tempMin: json['Temperature']['Minimum']['Value'].toString(),
      tempMax: json['Temperature']['Maximum']['Value'].toString(),
      day: json['Day']['IconPhrase'],
      windSpeed: json['Day']['Wind']['Speed']['Value'].toString(),
      windDirection: json['Day']['Wind']['Direction']['Localized'].toString(),
    );
  }
}

String accuDateFormat(String date) {
  DateTime dt = DateTime.parse(date);
  String formattedDate = DateFormat("dd/MM").format(dt);
  return formattedDate;
}

String accuDayFormat(String date) {
  DateTime dt = DateTime.parse(date);
  String formattedDate = DateFormat("E").format(dt);
  return formattedDate;
}
