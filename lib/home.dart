import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather/currentWeatherWidget.dart';
import 'package:weather/model.dart';
import 'package:weather/weatherWidget.dart';

class Home extends StatelessWidget {
  final List<Weather> weather;
  final currentWeather weatherData;
  final location loc;
  Home(this.weather, this.weatherData, this.loc, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
            minWidth: MediaQuery.of(context).size.width,
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/BGIMG.jpg"),
                fit: BoxFit.cover),
            // color: Colors.red,
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: currentWeatherWidget(weatherData, loc),
                    ),
                    Container(
                      child: Column(
                        children: [
                          for (Weather w in weather) weatherWidget(w),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
