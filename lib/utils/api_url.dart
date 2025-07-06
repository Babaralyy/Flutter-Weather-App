import '../api/api_key.dart';

String apiUrl(var lat, var long){
  return "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$long&exclude=minutely&appid=$apiKey&units=metric";
}