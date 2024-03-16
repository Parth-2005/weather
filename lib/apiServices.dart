import 'dart:convert';
import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather/model.dart';
// http://dataservice.accuweather.com/locations/v1/cities/geoposition/search
// http://dataservice.accuweather.com/currentconditions/v1/{locationkey}
// http://dataservice.accuweather.com/forecasts/v1/daily/5day/{locationkey}

class ApiServices {
  final String apiKey = 'API-KEY'; // AccuWeather API Key
  Future<List<double>> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition()
        .then((position) => [position.latitude, position.longitude]);
  }

  // TODO: Implement the search functionality
  Future<String> searchLocation() async {
    List<double> pos = await determinePosition();
    String post = "${pos[0]},${pos[1]}";
    final data = {'apikey': apiKey, 'q': post};
    final Uri url = Uri.http("dataservice.accuweather.com",
        "/locations/v1/cities/geoposition/search", data);
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data['Key'];
    } else {
      return Future.error('error');
    }
  }

  Future<location> getLocation() async {
    List<double> pos = await determinePosition();
    String post = "${pos[0]},${pos[1]}";
    final data = {'apikey': apiKey, 'q': post};
    final Uri url = Uri.http("dataservice.accuweather.com",
        "/locations/v1/cities/geoposition/search", data);
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      location loc = location.fromJson(data);
      return loc;
    } else {
      return Future.error('error');
    }
  }

  Future<currentWeather> getWeather() async {
    String locationKey = await searchLocation();
    final data = {'apikey': apiKey, 'language': 'en-us', 'details': 'true'};
    final Uri url = Uri.http("dataservice.accuweather.com",
        '/currentconditions/v1/$locationKey', data);
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    try {
      var response = await http.get(url, headers: headers);
      currentWeather weather =
          currentWeather.fromJson(json.decode(response.body)[0]);
      return weather;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<Weather>> getForecast() async {
    String locationKey = await searchLocation();
    final data = {
      'apikey': apiKey,
      'metric': 'true',
      'language': 'en-us',
      'details': 'true'
    };
    final Uri url = Uri.http("dataservice.accuweather.com",
        '/forecasts/v1/daily/5day/$locationKey', data);
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    try {
      List<Weather> weather = [];
      var response = await http.get(url, headers: headers);
      List<dynamic> data = json.decode(response.body)['DailyForecasts'];
      for (var element in data) {
        weather.add(Weather.fromJson(element));
      }
      return weather;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<Weather>> get15DayForecast() async {
    String locationKey = await searchLocation();
    final data = {
      'apikey': apiKey,
      'metric': 'true',
      'language': 'en-us',
      'details': 'true'
    };
    final Uri url = Uri.http("dataservice.accuweather.com",
        '/forecasts/v1/daily/15day/$locationKey', data);
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    try {
      List<Weather> weather = [];
      var response = await http.get(url, headers: headers);
      List<dynamic> data = json.decode(response.body)['DailyForecasts'];
      for (var element in data) {
        weather.add(Weather.fromJson(element));
      }
      return weather;
    } catch (e) {
      return Future.error(e);
    }
  }
}
