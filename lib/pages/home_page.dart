// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather_app/cubits/weather_cubit/weather_state.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/search_page.dart';

// we use statfullwidget to rebuild with new data

class HomePage extends StatelessWidget {
  WeatherModel? weatherData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SearchPage();
                    },
                  ),
                );
              },
              icon: Icon(Icons.search)),
        ],
        title: Text('Weather App'),
      ),
      //here i check the state using blocbuilder
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          //if the coming state is weatherloading
          if (state is WeatherLoading) {
            //show progressindicator
            return Center(
              child: CircularProgressIndicator(),
            );
            //if state is weathersuccess, build the container that show UI of data
          } else if (state is WeatherSuccess) {
            //to access weather data in weathercubit i use blocprovider and store it in weatherdata then send it to successbody
          
            return SuccessBody(weatherData: state.weatherModel);
            //if state is weatherfaهluer
          } else if (state is WeatherFailuer) {
            // show this message
            return Center(
              child: Text('somthing went wrong please try again'),
            );
            // otherwise show the defult state
          } else {
            return DefaultBody();
          }
        },
      ),
    );
  }
}

//default screen
class DefaultBody extends StatelessWidget {
  const DefaultBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'there is no weather 😔 start',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          Text(
            'searching now 🔍',
            style: TextStyle(
              fontSize: 30,
            ),
          )
        ],
      ),
    );
  }
}

//-------------------------------------------------------
//success state
class SuccessBody extends StatelessWidget {
  const SuccessBody({
    Key? key,
    required this.weatherData,
  }) : super(key: key);

  final WeatherModel? weatherData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          weatherData!.getThemeColor(),
          weatherData!.getThemeColor()[300]!,
          weatherData!.getThemeColor()[100]!,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
      //color: Colors.orange,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Spacer(
          flex: 3,
        ),
        Text(
          ////i access cityname from weathercubit
          BlocProvider.of<WeatherCubit>(context).cityName!,
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        Text(
          'updated at:${weatherData!.date}',
          style: TextStyle(
            fontSize: 22,
          ),
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(weatherData!.getImage()),
            Column(
              children: [
                Text(
                  '${weatherData!.currentTemp.toInt()}',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${weatherData!.temp.toInt()}',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              children: [
                //this will gat the temp from api and convert it to intger then show it
                Text('maxTemp:${weatherData!.maxTemp.toInt()}'),
                Text('minTemp:${weatherData!.minTemp.toInt()}'),
              ],
            )
          ],
        ),
        Spacer(),
        Text(
          //explanition of next statment:
          //if weatherdata is null , show empty string
          weatherData!.condition,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(
          flex: 5,
        ),
      ]),
    );
  }
}
