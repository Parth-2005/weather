import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather/model.dart';

class currentWeatherWidget extends StatelessWidget {
  final currentWeather weather;
  final location loc;
  currentWeatherWidget(this.weather, this.loc, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0),
          blendMode: BlendMode.srcOver,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade900.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
              border:
                  Border.all(color: Colors.white.withOpacity(0.3), width: 0.5),
            ),
            child: Column(children: [
              Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text("${weather.weekday}",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white)),
                          Text("${weather.dateTime}",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                        ],
                      ),
                      Column(
                        children: [
                          Text("${loc.name}",
                              style:
                                  TextStyle(fontSize: 40, color: Colors.white))
                        ],
                      )
                    ]),
              ),
              //Main
              Container(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Column(children: [
                    Text(
                      "${weather.Temperature}°C",
                      style: TextStyle(
                          fontWeight: FontWeight.w200,
                          color: Colors.white,
                          fontSize: 90),
                    ),
                    Text(
                      "${weather.WeatherText}",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    )
                  ])
                ]),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          constraints: BoxConstraints(minWidth: 110),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Icon(
                                  Icons.water_drop_outlined,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                Text(
                                  "${weather.humidity}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 26),
                                ),
                              ]),
                        ),
                      ],
                    ),
                    // Wind
                    Column(
                      children: [
                        Container(
                          constraints: BoxConstraints(minWidth: 110),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Icon(
                                  Icons.visibility,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                Text(
                                  "${weather.visibility} ",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 26),
                                ),
                                Text("km",
                                    style: TextStyle(color: Colors.white))
                              ]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          constraints: BoxConstraints(minWidth: 110),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Icon(
                                  Icons.download,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                Text(
                                  "${weather.pressure} ",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 26),
                                ),
                                Text("kb",
                                    style: TextStyle(color: Colors.white))
                              ]),
                        ),
                      ],
                    ),
                    // Wind
                    Column(
                      children: [
                        Container(
                          constraints: BoxConstraints(minWidth: 110),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Icon(
                                  Icons.air,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                Text(
                                  " ${weather.windSpeed} ",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 26),
                                ),
                                Text("km/h",
                                    style: TextStyle(color: Colors.white))
                              ]),
                        ),
                        Text("${weather.windDirection}",
                            style:
                                TextStyle(color: Colors.white, fontSize: 14)),
                      ],
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
