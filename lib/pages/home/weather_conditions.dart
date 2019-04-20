import 'package:flutter/material.dart';

import 'package:meta/meta.dart';
import 'package:solocoding2019_base/models/weather_model.dart';

import 'package:flutter_svg/flutter_svg.dart';

class WeatherConditions extends StatelessWidget {
  final WeatherCondition condition;

  WeatherConditions({Key key, @required this.condition})
      : assert(condition != null),
        super(key: key);

  @override
  Widget build(BuildContext context) => _mapConditionToImage(condition);

  SvgPicture _mapConditionToImage(WeatherCondition condition) {
    SvgPicture image;
    switch (condition) {
      case WeatherCondition.clear:
      case WeatherCondition.lightCloud:
        image = SvgPicture.asset('assets/sun.svg', width: 80,height: 80, fit: BoxFit.contain);
        break;
      case WeatherCondition.hail:
      case WeatherCondition.snow:
      case WeatherCondition.sleet:
        image = SvgPicture.asset('assets/snow.svg', width: 80,height: 80, fit: BoxFit.contain);
        break;
      case WeatherCondition.heavyCloud:
        image = SvgPicture.asset('assets/cloud.svg', width: 80,height: 80, fit: BoxFit.contain);
        break;
      case WeatherCondition.heavyRain:
      case WeatherCondition.lightRain:
      case WeatherCondition.showers:
        image = SvgPicture.asset('assets/rain.svg', width: 80,height: 80, fit: BoxFit.contain);
        break;
      case WeatherCondition.thunderstorm:
        image = SvgPicture.asset('assets/storm.svg', width: 80,height: 80, fit: BoxFit.contain);
        break;
      case WeatherCondition.unknown:
        image = SvgPicture.asset('assets/sun.svg', width: 80,height: 80, fit: BoxFit.contain);
        break;
    }
    return image;
  }
}
