import 'dart:convert';
import 'dart:async';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:solocoding2019_base/models/forecast_model.dart';
import 'package:solocoding2019_base/models/weather_model.dart';

import 'package:location/location.dart';

class WeatherApiClient {
  static const baseUrl = 'https://api.openweathermap.org/data/2.5';  //'https://www.metaweather.com';
  static const apiKey = '';
  final http.Client httpClient;

  WeatherApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<int> getLocationId(String city) async {
    final locationUrl = '$baseUrl/api/location/search/?query=$city';
    final locationResponse = await this.httpClient.get(locationUrl);
    if (locationResponse.statusCode != 200) {
      throw Exception('error getting locationId for city');
    }

    final locationJson = jsonDecode(locationResponse.body) as List;
    return (locationJson.first)['woeid'];
  }

//  Future<Weather> fetchWeather(int locationId) async {
//    final weatherUrl = '$baseUrl/api/location/$locationId';
//    final weatherResponse = await this.httpClient.get(weatherUrl);
//
//    if (weatherResponse.statusCode != 200) {
//      throw Exception('error getting weather for location');
//    }
//
//    final weatherJson = jsonDecode(weatherResponse.body);
//    return Weather.fromJson(weatherJson);
//  }


  Future<Weathers> fetchWeather(LocationData locationData) async {
    final lat = locationData.latitude;
    final lon = locationData.longitude;
    final weatherUrl = '$baseUrl/weather?lat=$lat&lon=$lon&appid=$apiKey';  //'$baseUrl/api/location/$locationId';
    final weatherResponse = await this.httpClient.get(weatherUrl);

    if (weatherResponse.statusCode != 200) {
      throw Exception('error getting weather for location');
    }

    final weatherJson = jsonDecode(weatherResponse.body);
    return Weathers.fromJson(weatherJson);
  }



  Future<Weathers> fetchWeatherFromName(String city) async {
    final weatherUrl = '$baseUrl/weather?q=$city&appid=$apiKey';  //'$baseUrl/api/location/$locationId';
    final weatherResponse = await this.httpClient.get(weatherUrl);

    if (weatherResponse.statusCode != 200) {
      throw Exception('error getting weather for location');
    }

    final weatherJson = jsonDecode(weatherResponse.body);
    return Weathers.fromJson(weatherJson);
  }

  Future<Weathers> fetchWeatherFromID(int locationID) async {
    final weatherUrl = '$baseUrl/weather?id=$locationID&&appid=$apiKey';  //'$baseUrl/api/location/$locationId';
    final weatherResponse = await this.httpClient.get(weatherUrl);

    if (weatherResponse.statusCode != 200) {
      throw Exception('error getting weather for location');
    }

    final weatherJson = jsonDecode(weatherResponse.body);
    return Weathers.fromJson(weatherJson);
  }

  Future<ForecastWeathers> fetchForecastWeather(LocationData locationData) async {
    final lat = locationData.latitude;
    final lon = locationData.longitude;
    final forecastWeatherUrl = '$baseUrl/forecast?APPID=$apiKey&lat=$lat&lon=$lon';  //'$baseUrl/api/location/$locationId';
    final weatherResponse = await this.httpClient.get(forecastWeatherUrl);

    if (weatherResponse.statusCode != 200) {
      throw Exception('error getting weather for location');
    }

    final weatherJson = jsonDecode(weatherResponse.body);
    return ForecastWeathers.fromJson(weatherJson);
  }

  Future<ForecastWeathers> fetchForecastWeatherFromID(int locationID) async {
    final forecastWeatherUrl = '$baseUrl/forecast?id=$locationID&appid=$apiKey';  //'$baseUrl/api/location/$locationId';
    final weatherResponse = await this.httpClient.get(forecastWeatherUrl);

    if (weatherResponse.statusCode != 200) {
      throw Exception('error getting weather for location');
    }

    final weatherJson = jsonDecode(weatherResponse.body);
    return ForecastWeathers.fromJson(weatherJson);
  }

  Future<ForecastWeathers> fetchForecastWeatherFromName(String city) async {
    final forecastWeatherUrl = '$baseUrl/forecast?q=$city&appid=$apiKey';  //'$baseUrl/api/location/$locationId';
    final weatherResponse = await this.httpClient.get(forecastWeatherUrl);

    if (weatherResponse.statusCode != 200) {
      throw Exception('error getting weather for location');
    }

    final weatherJson = jsonDecode(weatherResponse.body);
    return ForecastWeathers.fromJson(weatherJson);
  }
}
