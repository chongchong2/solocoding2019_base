import 'package:flutter/material.dart';
import 'package:solocoding2019_base/models/forecast_model.dart';

class ForecastWeather extends StatelessWidget {
  final ForecastWeathers forecastWeathers;
  final now = DateTime.now();
  ForecastWeather({
    Key key,
    @required this.forecastWeathers,
  })  : assert(forecastWeathers != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(

//            forecastWeathers.forecastList[0].weather[0].main,
          _getweekday(now.weekday+1),
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w200,
            color: Colors.white,
          ),
        ),

        Container(
          height: 50,
          child: GridView.count(
            crossAxisCount: 8,
            children: new List<Widget>.generate(8, (index) {
              return new GridTile(
                child: new Container(
                    child: new Center(
                      child: new Text(_formattedTemperature(forecastWeathers
                          .forecastList[5 + index].main.temp)
                          .toString() +
                          '°'),
                    )),
              );
            }),
          ),
        ),
        Center(
          child: Text(
//            forecastWeathers.forecastList[0].weather[0].main,
            _getweekday(now.weekday+2),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w200,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          height: 50,
          child: GridView.count(
            crossAxisCount: 8,
            children: new List<Widget>.generate(8, (index) {
              return new GridTile(
                child: new Container(
                    child: new Center(
                      child: new Text(_formattedTemperature(forecastWeathers
                          .forecastList[13 + index].main.temp)
                          .toString() +
                          '°'),
                    )),
              );
            }),
          ),
        ),
        Center(
          child: Text(
//            forecastWeathers.forecastList[0].weather[0].main,
            _getweekday(now.weekday+3),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w200,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          height: 50,
          child: GridView.count(
            crossAxisCount: 8,
            children: new List<Widget>.generate(8, (index) {
              return new GridTile(
                child: new Container(
                    child: new Center(
                      child: new Text(_formattedTemperature(forecastWeathers
                          .forecastList[21 + index].main.temp)
                          .toString() +
                          '°'),
                    )),
              );
            }),
          ),
        )
      ],
    );
  }

  int _formattedTemperature(double t) => t.round();

  String _getweekday(int dateTime) {
    String weekDay = '';
    if(dateTime == 8) dateTime = 1;
    else if(dateTime == 9) dateTime = 2;
    switch(dateTime) {
      case DateTime.sunday :
        weekDay = '일요일';
        break;
      case DateTime.monday :
        weekDay = '월요일';
        break;
      case DateTime.tuesday :
        weekDay = '화요일';
        break;
      case DateTime.wednesday :
        weekDay = '수요일';
        break;
      case DateTime.thursday :
        weekDay = '목요일';
        break;
      case DateTime.friday :
        weekDay = '금요일';
        break;
      case DateTime.saturday :
        weekDay = '토요일';
        break;
    }
    return weekDay;
  }
}
