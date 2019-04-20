import 'dart:async';

import 'package:flutter/material.dart';
import 'package:solocoding2019_base/blocs/weather_bloc.dart';
import 'package:solocoding2019_base/models/weather_model.dart';
import 'package:solocoding2019_base/pages/home/current_weather.dart';
import 'package:solocoding2019_base/pages/home/forecast_weather.dart';
import 'package:solocoding2019_base/pages/home/location.dart';
import 'package:solocoding2019_base/pages/home/location_selection.dart';
import 'package:solocoding2019_base/repositories/file_storage.dart';
import 'package:solocoding2019_base/repositories/weather_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:path_provider/path_provider.dart';

class Home extends StatefulWidget {
  final WeatherRepository weatherRepository;

  Home({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  WeatherBloc _weatherBloc;
  Completer<void> _refreshCompleter;

//  var fileStorage = new FileStorage(
//    '__flutter_bloc_app__',
//    getApplicationDocumentsDirectory,
//  );

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    _weatherBloc = WeatherBloc(weatherRepository: widget.weatherRepository);

//    _weatherBloc.dispatch(FetchWeather(city: 'seoul'));
    _weatherBloc.dispatch(LocationWeather());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Weather'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final city = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LocationSelection(),
                ),
              );
              if (city != null) {
                _weatherBloc.dispatch(FetchWeather(city: city));
              }
            },
          )
        ],
      ),
      body: Center(
        child: BlocBuilder(
            bloc: _weatherBloc,
            builder: (_, WeatherState state) {
              if (state is WeatherEmpty) {
                return Center(child: Text(''));
              }
              if (state is WeatherLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is WeatherLoaded) {
//                var todos = new List<Weather>();
//                todos.add(state.weather);
//                fileStorage.saveTodos(todos);
//
//                var lod = fileStorage.loadTodos();

                final weathers = state.weathers;
                final forecastWeathers = state.forecastWeathers;
                print(weathers);
                _refreshCompleter?.complete();
                _refreshCompleter = Completer();
                return Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(163, 220, 226, 1.0),
                    ),
                    child: RefreshIndicator(
                      onRefresh: () {
                        _weatherBloc.dispatch(
                          RefreshWeather(locationId: state.weathers.id),
                        );
                        return _refreshCompleter.future;
                      },
                      child: ListView(
//                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
//                          LocationSelection(weatherBloc: _weatherBloc),
                          Padding(
                            padding: EdgeInsets.only(top: 70),
                            child: Center(
                              child: Text(
                                _getweekday(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Center(
                              child: Location(location: weathers.name),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              child: Center(
                                child: CurrentWeather(
                                  weathers: weathers,
                                ),
                              )),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              child: Center(
                                child: ForecastWeather(
                                  forecastWeathers: forecastWeathers,
                                ),
                              ))
                        ],
                      ),
                    ));
              }
            }),
      ),
    );
  }

  String _getweekday() {
    var now = new DateTime.now();
    String weekDay = '';
    switch (now.weekday) {
      case DateTime.sunday:
        weekDay = '일요일';
        break;
      case DateTime.monday:
        weekDay = '월요일';
        break;
      case DateTime.tuesday:
        weekDay = '화요일';
        break;
      case DateTime.wednesday:
        weekDay = '수요일';
        break;
      case DateTime.thursday:
        weekDay = '목요일';
        break;
      case DateTime.friday:
        weekDay = '금요일';
        break;
      case DateTime.saturday:
        weekDay = '토요일';
        break;
    }
    return now.month.toString() + '/' + now.day.toString() + ' ' + weekDay;
  }
}
