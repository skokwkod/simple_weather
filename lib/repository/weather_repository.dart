import '../models/weather.dart';

abstract class WeatherRepository{
  Future<Weather> fetchWeather(num cityId);
}