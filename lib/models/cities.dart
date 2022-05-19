import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class Cities {
  num id;
  String name;
  String country;
  String state;

  Cities({required this.name, required this.country, required this.state, required this.id});


  factory Cities.fromJson(Map<String, dynamic> json) {
    return Cities(
      id: json['id'],
      name: json['name'],
      country: json['country'],
      state: json['state'],
    );
  }

  static Future<List<Cities>> fetchCities(String cityName) async {

    final response = await rootBundle.loadString('lib/assets/city_list.json');
    final List<dynamic> data = await json.decode(response);
    print(cityName);
    List<Cities> selectedCity = List<Cities>.from(data.map((e) => Cities.fromJson(e)).where((city) => city.name.contains(cityName)));

    return selectedCity;

    // final response = await http.get(Uri.parse('http://api.openweathermap.org/geo/1.0/direct?q='+cityName+'&limit=4&appid=818eb6d59452047d1ffbdb20e1b9ff83'),
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },);
    //
    // if (response.statusCode == 200) {
    //
    //   List<dynamic> parsedListJson = jsonDecode(response.body);
    //   List<Cities> selectedCity = List<Cities>.from(parsedListJson.map((i) => Cities.fromJson(i)));
    //
    //   print(selectedCity[0].name);
    //   return selectedCity;
    // } else {
    //   // If the server did not return a 200 OK response,
    //   // then throw an exception.
    //   throw Exception('Failed to load cities');
    // }
  }

}
