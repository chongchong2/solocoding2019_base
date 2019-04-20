import 'dart:async';

import 'package:location/location.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:solocoding2019_base/models/forecast_model.dart';
import 'package:solocoding2019_base/models/weather_model.dart';
import 'package:solocoding2019_base/repositories/weather_repository.dart';

abstract class WeatherEvent extends Equatable {
  WeatherEvent([List props = const []]) : super(props);
}

class LocationWeather extends WeatherEvent {
  @override
  String toString() => 'LocationWeather';
}

class FetchWeather extends WeatherEvent {
  final String city;

  FetchWeather({@required this.city})
      : assert(city != null),
        super([city]);
}

class RefreshWeather extends WeatherEvent {
  final int locationId;

  RefreshWeather({@required this.locationId})
      : assert(locationId != null),
        super([locationId]);
}



abstract class WeatherState extends Equatable {
  WeatherState([List props = const []]) : super(props);
}

class WeatherEmpty extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weathers weathers;
  final ForecastWeathers forecastWeathers;

  WeatherLoaded({@required this.weathers, @required this.forecastWeathers})
      : assert(weathers != null && forecastWeathers != null),
        super([weathers, forecastWeathers]);
}

class WeatherError extends WeatherState {}




class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({@required this.weatherRepository})
      : assert(weatherRepository != null);

  @override
  WeatherState get initialState => WeatherEmpty();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if(event is LocationWeather) {
      yield WeatherLoading();
      try{
        LocationData currentLocation;
        var location = new Location();

        currentLocation = await location.getLocation();
        final Weathers weathers = await weatherRepository.getWeather(currentLocation);
        final ForecastWeathers forecastWeathers = await weatherRepository.getForecastWeather(currentLocation);
        yield WeatherLoaded(weathers: weathers, forecastWeathers: forecastWeathers);
      }catch(e){
        yield WeatherError();
      }
    }

    if (event is FetchWeather) {
      yield WeatherLoading();
      try {
        final Weathers weathers = await weatherRepository.getWeatherFromName(event.city);
        final ForecastWeathers forecastWeathers = await weatherRepository.getForecastWeatherFromName(event.city);
        yield WeatherLoaded(weathers: weathers, forecastWeathers: forecastWeathers);
      } catch (_) {
        yield WeatherError();
      }
    }

    if (event is RefreshWeather) {
      try {
        final Weathers weathers = await weatherRepository.getWeatherFromID(event.locationId);
        final ForecastWeathers forecastWeathers = await weatherRepository.getForecastWeatherFromID(event.locationId);
        yield WeatherLoaded(weathers: weathers, forecastWeathers: forecastWeathers);
      } catch (_) {
        yield currentState;
      }
    }
  }
}
