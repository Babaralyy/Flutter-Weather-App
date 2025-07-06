import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/weather_info.dart';
import '../utils/api_url.dart';

class FetchWeather{
  late WeatherInfo weatherInfo;

  Future<WeatherInfo> fetchWeatherInfo(lat, long) async{
    var response = await http.get(Uri.parse(apiUrl(lat, long)));
    var jsonString = jsonDecode(response.body);
    weatherInfo = WeatherInfo.fromJson(jsonString);
    return weatherInfo;
  }
}