import 'package:flutter/material.dart';
import 'package:solocoding2019_base/models/forecast_model.dart';

class ForecastWeather extends StatelessWidget {
  final ForecastWeathers forecastWeathers;
//  final now = DateTime.now();
  var now = new DateTime.now().add(new Duration(days: 10));
  ForecastWeather({
    Key key,
    @required this.forecastWeathers,
  })  : assert(forecastWeathers != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 10),
          alignment: Alignment(-1.0, 0.0),
          child : Text(
            _getweekday(now.add(new Duration(days: 1))),
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w200,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          height: 70,
          child: GridView.count(
            crossAxisCount: 8,
            children: new List<Widget>.generate(8, (index) {
              return new GridTile(
                child: new Container(
                  padding: EdgeInsets.all(0),
                  child: new Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: new Text(
                          _gethour(forecastWeathers.forecastList[5 + index].dtTxt),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 0.0),
                        child: new Text(_formattedTemperature(forecastWeathers
                            .forecastList[5 + index].main.temp)
                            .toString() +
                            '°',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w200,
                                color: Colors.white
                            ),),
                      )
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10),
          alignment: Alignment(-1.0, 0.0),
          child : Text(
            _getweekday(now.add(new Duration(days: 2))),
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w200,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          height: 70,
          child: GridView.count(
            crossAxisCount: 8,
            children: new List<Widget>.generate(8, (index) {
              return new GridTile(
                child: new Container(
                  padding: EdgeInsets.all(0),
                  child: new Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: new Text(
                          _gethour(forecastWeathers.forecastList[13 + index].dtTxt),
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.white
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 0.0),
                        child: new Text(_formattedTemperature(forecastWeathers
                            .forecastList[13 + index].main.temp)
                            .toString() +
                            '°',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w200,
                              color: Colors.white
                          ),),
                      )
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10),
          alignment: Alignment(-1.0, 0.0),
          child : Text(
            _getweekday(now.add(new Duration(days: 3))),
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w200,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          height: 70,
          child: GridView.count(
            crossAxisCount: 8,
            children: new List<Widget>.generate(8, (index) {
              return new GridTile(
                child: new Container(
                  padding: EdgeInsets.all(0),
                  child: new Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: new Text(
                          _gethour(forecastWeathers.forecastList[21 + index].dtTxt),
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.white
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 0.0),
                        child: new Text(_formattedTemperature(forecastWeathers
                            .forecastList[21 + index].main.temp)
                            .toString() +
                            '°',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w200,
                              color: Colors.white
                          ),),
                      )
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  int _formattedTemperature(double t) => t.round();

  String _getweekday(DateTime dateTime) {
    String weekDay = '';
//    if(dateTime == 8) dateTime = 1;
//    else if(dateTime == 9) dateTime = 2;
    switch(dateTime.weekday) {
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
//    return now.month.toString() + '/' + now.day.toString() + ' ' + weekDay;
    return dateTime.month.toString() + '/' + dateTime.day.toString() + ' ' +  weekDay;
  }

  String _gethour(String raw) {
    var hours = raw.split(' ');
    var result = hours[1].split(':');
    return result[0] + '시';
  }
}
