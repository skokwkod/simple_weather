import '../models/cities.dart';

abstract class CityRepository{
  Future<Cities> fetchCities(String cityName);
}