import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:weather/home.dart';
import 'package:weather/model.dart';
import 'package:weather/apiServices.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Weather> weather = [
    Weather(
        weekday: "",
        date: "",
        tempMin: "",
        tempMax: "",
        day: "",
        windSpeed: "",
        windDirection: "")
  ];
  currentWeather crrWeather = currentWeather(
      WeatherText: "",
      Temperature: "",
      windSpeed: "",
      windDirection: "",
      dateTime: "",
      weekday: "",
      humidity: "",
      visibility: "",
      pressure: '');

  location loc = location(name: "");

  @override
  void initState() {
    super.initState();
    ApiServices().getWeather().then((value) {
      setState(() {
        crrWeather = value;
      });
    });
    ApiServices().getForecast().then((value) {
      setState(() {
        weather = value;
      });
    });
    ApiServices().getLocation().then((value) {
      setState(() {
        loc = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Home(weather, crrWeather, loc),
      );
    });
  }
}
