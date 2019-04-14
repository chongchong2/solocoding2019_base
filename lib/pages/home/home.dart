import 'dart:async';

import 'package:flutter/material.dart';
import 'package:solocoding2019_base/blocs/weather_bloc.dart';
import 'package:solocoding2019_base/repositories/weather_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    _weatherBloc = WeatherBloc(weatherRepository: widget.weatherRepository);


    _weatherBloc.dispatch(FetchWeather(city: 'seoul'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(


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
              final weather = state.weather;
              print(weather);


              _refreshCompleter?.complete();
              _refreshCompleter = Completer();
              return RefreshIndicator(
                onRefresh: () {
                  _weatherBloc.dispatch(
                    RefreshWeather(city: state.weather.location),
                  );
                    return _refreshCompleter.future;
                  },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Text('current : ${weather.temp.round()}°'),
                    Text('max : ${weather.maxTemp.round()}°'),
                    Text('min : ${weather.minTemp.round()}°'),
                    Text('${weather.condition}°'),
                  ],
                ),
              );
            }
          }
        ),
      ),
    );
  }

}