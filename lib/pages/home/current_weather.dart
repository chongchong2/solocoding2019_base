import 'package:flutter/material.dart';
import 'package:solocoding2019_base/models/weather_model.dart';
import 'package:solocoding2019_base/pages/home/temperature.dart';
import 'package:solocoding2019_base/pages/home/weather_conditions.dart';

import 'dart:math';

class CurrentWeather extends StatelessWidget {
  final Weathers weathers;

  CurrentWeather({
    Key key,
    @required this.weathers,
  })  : assert(weathers != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(20.0),
                child: Image.network('http://openweathermap.org/img/w/${weathers.weather[0].icon}.png')
              //WeatherConditions(condition: weathers.weather),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Temperature(
                temperature: (weathers.main.temp),
                high: (weathers.main.temp_max),
                low: (weathers.main.temp_min),
              ),
            )
          ],
        ),
//        Center(
//
//          child: Text(
////            weathers.weather[0].main,
//            _getweekday(),
//            style: TextStyle(
//              fontSize: 30,
//              fontWeight: FontWeight.w200,
//              color: Colors.white,
//            ),
//          ),
//        ),
      ],
    );
  }

  double FahrenheitToCelsius(dynamic t) =>
      t.round();


}
