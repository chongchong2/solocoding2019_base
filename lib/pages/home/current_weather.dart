import 'package:flutter/material.dart';
import 'package:solocoding2019_base/models/weather_model.dart';
import 'package:solocoding2019_base/pages/home/temperature.dart';
import 'package:solocoding2019_base/pages/home/weather_conditions.dart';

class CurrentWeather extends StatelessWidget {
  final Weather weather;

  CurrentWeather({
    Key key,
    @required this.weather,
  })  : assert(weather != null),
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
              child: WeatherConditions(condition: weather.condition),
            ),
            Padding(
                padding: EdgeInsets.all(20.0),
                child: Temperature(
                  temperature: weather.temp,
                  high: weather.maxTemp,
                  low: weather.minTemp,
                )),
          ],
        ),
        Center(
          child: Text(
            weather.formattedCondition,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w200,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
