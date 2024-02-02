//creating all states possible for this app
import 'package:weather_app/models/weather_model.dart';

abstract class WeatherState {}

//weatherinitial is the defult state
class WeatherInitial extends WeatherState {}

//loading state
class WeatherLoading extends WeatherState {}

//success state
class WeatherSuccess extends WeatherState {
  //in case success store data inside state
  WeatherModel weatherModel;
  WeatherSuccess({required this.weatherModel});
}

//failuer state
class WeatherFailuer extends WeatherState {}
