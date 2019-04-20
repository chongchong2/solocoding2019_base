import 'package:location/location.dart';
import 'package:meta/meta.dart';
import 'package:solocoding2019_base/models/forecast_model.dart';
import 'package:solocoding2019_base/models/weather_model.dart';
import 'package:solocoding2019_base/repositories/weather_api_client.dart';


class WeatherRepository {
  final WeatherApiClient weatherApiClient;

  WeatherRepository({@required this.weatherApiClient})
      : assert(weatherApiClient != null);

  Future<Weathers> getWeather(LocationData locationData) async {
    return await weatherApiClient.fetchWeather(locationData);
  }

  Future<Weathers> getWeatherFromName(String city) async {
    return await weatherApiClient.fetchWeatherFromName(city);
  }

  Future<Weathers> getWeatherFromID(int locationID) async {
    return await weatherApiClient.fetchWeatherFromID(locationID);
  }

  Future<ForecastWeathers> getForecastWeatherFromName(String city) async {
    return await weatherApiClient.fetchForecastWeatherFromName(city);
  }

  Future<ForecastWeathers> getForecastWeather(LocationData locationData) async {
    return await weatherApiClient.fetchForecastWeather(locationData);
  }

  Future<ForecastWeathers> getForecastWeatherFromID(int locationID) async {
    return await weatherApiClient.fetchForecastWeatherFromID(locationID);
  }
}
