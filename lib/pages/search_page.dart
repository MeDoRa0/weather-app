import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/services/weather_service.dart';

class SearchPage extends StatelessWidget {
  String? cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search a City"),
      ),
      //TextField is a widget that take input from user
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextField(
            //onChanged is used to keep taking data from user while he type in textfield, good for auto-complete
            onChanged: (data) {
              cityName = data;
            },
            //onSubmitted is used to take data from textfield after user submit his input
            onSubmitted: (data) async {
              cityName = data;
              //using blocprovider we will get weather data from weathercubit
              BlocProvider.of<WeatherCubit>(context)
                  .getWeather(cityName: cityName!);
                  //i access cityname from weathercubit
              BlocProvider.of<WeatherCubit>(context).cityName = cityName;
              //after after weather data come, back to home page and show the weather data
              Navigator.pop(context);
            },

            // to customize textfield shape
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
              label: const Text("search"),
              //suufixIcon will show the icon in left of textfield
              suffixIcon: GestureDetector(
                  onTap: () async {
                    WeatherService service = WeatherService();
                    WeatherModel? weather =
                        await service.getWeather(cityName: cityName!);

                    // to access object weather of weathermodel in main.dart , i use provider here
                    Provider.of<weatherProvider>(context, listen: false)
                        .weatherData = weather;
                    Provider.of<weatherProvider>(context, listen: false)
                        .cityName = cityName;
                    //this will back to home page with weather data
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.search)),
              border: const OutlineInputBorder(),
              hintText: 'Enter a City',
            ),
          ),
        ),
      ),
    );
  }
}
