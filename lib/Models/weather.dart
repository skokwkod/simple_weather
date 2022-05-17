import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Weather {

  String mainWeather;
  String description;
  String iconId;
  // double tempNow;
  // double tempMin;
  // double tempMax;
  // double tempFeelsLike;
  // int pressure;


  Weather({required this.mainWeather, required this.description, required this.iconId});

  factory Weather.fromJson(Map<String, dynamic> json){
    return Weather(
        mainWeather: json['main'],
        description: json['description'],
        iconId: json['icon']);
        // tempNow: json['main'][0]['temp'],
        // tempMin: json['main'][0]['temp_min'],
        // tempMax: json['main'][0]['temp_max'],
        // tempFeelsLike: json['main'][0]['feels_like'],
        // pressure: json['main'][0]['pressure']);
  }

  static Future<List<Weather>> fetchWeather(num cityId) async {
    List<Weather> list;
    final response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?appid=818eb6d59452047d1ffbdb20e1b9ff83&id='+cityId.toString()+'&units=metric&lang=pl'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },);

    if (response.statusCode == 200) {

      var parsedMapJson = jsonDecode(response.body);
      var rest = parsedMapJson["weather"] as List;
      print(rest);
      list = rest.map<Weather>((json) => Weather.fromJson(json)).toList();
      print(list[0].mainWeather);
      return list;
    } else {

      throw Exception('Failed to load weather');
    }


  }
}