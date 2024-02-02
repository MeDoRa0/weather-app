import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
//this class contain data i provide

class weatherProvider extends ChangeNotifier {
  //_ will make the variable privte
  WeatherModel? _weatherData;
  String? cityName;
  set weatherData(WeatherModel? weather) {
    _weatherData = weather;
    //this statment tell any code use weather data that this data is updated
    notifyListeners();
  }

  WeatherModel? get weatherData => _weatherData;
}
