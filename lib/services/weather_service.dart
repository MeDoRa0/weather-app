import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  String baseUrl = 'http://api.weatherapi.com/v1';
  String apiKey = '7ad01576c1804b9191d162602230705&q';
  // async to use await
  // Future to tell the compiler that weather will get data in future
  Future<WeatherModel?> getWeather({required String cityName}) async {
    //object of  type uri named url
    //parse take the string and convert it to object to use it in get function
    //try and catch in case user enter any word not city
    WeatherModel? weather;
    try {
      Uri url = Uri.parse(
          '$baseUrl/forecast.json?key=$apiKey=$cityName&days=10&aqi=no&alerts=no');
      //response to recive data
      //using await because response use future
      http.Response response = await http.get(url);
      //jsondecode is a function take string that i want convert to json
      // type of data < key , value> name =
      // we use dynamic in case api change data type of values
      Map<String, dynamic> data = jsonDecode(response.body);
      //object contain all data we need from api
       weather = WeatherModel.fromJson(data);
    } catch (e) {
      print(e);
    }
    return weather;
  }
}
