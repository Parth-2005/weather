import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather/model.dart';

class weatherWidget extends StatelessWidget {
  final Weather weather;
  weatherWidget(this.weather, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0),
          blendMode: BlendMode.srcOver,
          child: Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade900.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: Colors.white.withOpacity(0.3), width: 0.5),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(children: [
                      Text("${weather.weekday}",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Text("${weather.date}",
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ]),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${weather.tempMax}°C",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${weather.tempMin}°C",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        )
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
                                  "${weather.windSpeed} ",
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
                  ])),
        ),
      ),
    );
  }
}
