import 'package:dio/dio.dart';
import 'package:simple_weather/models/weather.dart';
import 'package:simple_weather/repository/weather_repository.dart';


class WeatherRepositoryImp implements WeatherRepository {
  @override
  Future<Weather> fetchWeather(num cityId) async {

    final Dio _dio = Dio();
    final String _url = "https://api.openweathermap.org/data/2.5/weather?appid=818eb6d59452047d1ffbdb20e1b9ff83&id="+cityId.toString()+"&units=metric&lang=pl";

    try{
      Response response = await _dio.get(_url);
      print(response);
      Map<String, dynamic> json = response.data;
      print("JSON Weather"+json['weather'].toString());
        return Weather.fromJson(json["weather"][0]);
    }catch(error, stackTrace){
      print(error.toString()+"   "+stackTrace.toString());
    }
    throw 'Ojj';
  }
}
