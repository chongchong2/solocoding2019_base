import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';

import 'package:solocoding2019_base/pages/home/home.dart';
import 'package:solocoding2019_base/repositories/file_storage.dart';
import 'package:solocoding2019_base/repositories/weather_api_client.dart';
import 'package:solocoding2019_base/repositories/weather_repository.dart';
import 'package:path_provider/path_provider.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  onTransition(Transition transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    super.onError(error, stacktrace);
    print(error);
  }
}

void main() {
  final WeatherRepository weatherRepository = WeatherRepository(
    weatherApiClient: WeatherApiClient(
      httpClient: http.Client(),
    ),
  );

  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(App(weatherRepository: weatherRepository));
}

class App extends StatefulWidget {
  final WeatherRepository weatherRepository;
//  final todosBloc = TodosBloc(
//    todosRepository: const TodosRepositoryFlutter(
//      fileStorage: const FileStorage(
//        '__flutter_bloc_app__',
//        getApplicationDocumentsDirectory,
//      ),
//    ),
//  );
  App({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Weather',

      home: Home(
        weatherRepository: widget.weatherRepository,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
