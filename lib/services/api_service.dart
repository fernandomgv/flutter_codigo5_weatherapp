import 'dart:convert';

import 'package:flutter_codigo5_weatherapp/model/weather_model.dart';
import 'package:http/http.dart' as http;

class ApiService{

 Future<WeatherModel?> getDataWeather( String city) async{
    // String path = "https://api.openweathermap.org/data/2.5/weather?lat=-12.050947&lon=-76.9677389&units=metric&appid=ddd4c78c9bfe1e96c4c6165f8bb0d7bd";
    String path = "https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=ddd4c78c9bfe1e96c4c6165f8bb0d7bd";
    Uri _uri = Uri.parse(path);

    http.Response response = await http.get(_uri);
    if(response.statusCode == 200){
      print(response.statusCode);

      Map <String, dynamic> myMap = json.decode(response.body);
      WeatherModel weatherModel = WeatherModel.fromJson(myMap);
      print(weatherModel.main.temp);
      return weatherModel;

    }
    return null;
  }
 Future<WeatherModel?> getDataWeatherLocation( double lat, double lon) async{
   String path = "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=ddd4c78c9bfe1e96c4c6165f8bb0d7bd";
   //String path = "https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=ddd4c78c9bfe1e96c4c6165f8bb0d7bd";
   Uri _uri = Uri.parse(path);

   http.Response response = await http.get(_uri);
   if(response.statusCode == 200){
     print(response.statusCode);
     Map <String, dynamic> myMap = json.decode(response.body);
     WeatherModel weatherModel = WeatherModel.fromJson(myMap);
     print(weatherModel.main.temp);
     return weatherModel;
   }
   return null;
 }
}