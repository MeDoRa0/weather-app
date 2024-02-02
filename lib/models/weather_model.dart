import 'package:flutter/material.dart';

class WeatherModel {
  String date;
  double currentTemp;
  double temp;
  double maxTemp;
  double minTemp;
  String condition;

  WeatherModel({
    required this.date,
    required this.temp,
    required this.maxTemp,
    required this.minTemp,
    required this.condition,
    required this.currentTemp,
  });
  //weatherModel that take data from api json
  //factory constructor
  // we use factrory to let the code accept that field is non nullable
  factory WeatherModel.fromJson(dynamic data) {
    var jsonData = data['forecast']['forecastday'][0]['day'];
    //the comment below was normal constructor
    /* date = data['location']['localtime'];
    temp = jsonData['avgtemp_c'];
    maxTemp = jsonData['maxtemp_c'];
    minTemp = jsonData['mintemp_c'];
    condition = jsonData['condition']['text'];*/
    return WeatherModel(
      date: data['location']['localtime'],
      currentTemp: data['current']['temp_c'],
      temp: jsonData['avgtemp_c'],
      maxTemp: jsonData['maxtemp_c'],
      minTemp: jsonData['mintemp_c'],
      condition: jsonData['condition']['text'],
    );
  }
  //toString used to call when i print weather
  /* @override
  String toString() {
    // TODO: implement toString
    return 'temp= $temp mintemp=$minTemp date=$date';*/
  String getImage() {
    if (condition == 'sunny' || condition == 'Clear') {
      return 'assets/images/clear.png';
    } else if (condition == 'Cloudy') {
      return 'assets/images/cloudy.png';
    } else if (condition == 'Patchy light drizzle') {
      return 'assets/images/rainy.png';
    } else if (condition == 'Light snow') {
      return 'assets/images/snow.png';
    } else if (condition == 'Moderate or heavy rain with thunder') {
      return 'assets/images/thunderstorm.png';
    } else {
      return 'assets/images/clear.png';
    }
  }

  // color theme change depend on condition
  MaterialColor getThemeColor() {
    if (condition == 'sunny' || condition == 'Clear') {
      return Colors.lightBlue;
    } else if (condition == 'Cloudy') {
      return Colors.blueGrey;
    } else if (condition == 'Patchy light drizzle') {
      return Colors.blue;
    } else if (condition == 'Light snow') {
      return Colors.red;
    } else if (condition == 'Moderate or heavy rain with thunder') {
      return Colors.yellow;
    } else {
      return Colors.lightBlue;
    }
  }
}
