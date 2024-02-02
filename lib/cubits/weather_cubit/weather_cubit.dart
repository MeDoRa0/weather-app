import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather_cubit/weather_state.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherCubit extends Cubit<WeatherState> {
  //here i intiate object but i did not creat it, but i will creat this object when i creat weathercubit
  WeatherService weatherService;
  //i access cityname from weatherprovider, so i need to make cityname here
  String? cityName;
  WeatherModel? weatherModel;

  WeatherCubit(this.weatherService) : super(WeatherInitial());
  void getWeather({required String cityName}) async {
    //once getweather function is called, weatherloading state will run
    emit(WeatherLoading());
    try {
      WeatherModel? weatherModel = await weatherService.getWeather(cityName: cityName); 
      //after weather data is recived , weathersuccess state will run
      emit(WeatherSuccess(weatherModel:weatherModel!));
    } on Exception catch (e) {
      //if weather data did not come, weatherfailuer state will run
      emit(WeatherFailuer());
    }
  }
}
