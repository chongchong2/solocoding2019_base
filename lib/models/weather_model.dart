import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

enum WeatherCondition {
  snow,
  sleet,
  hail,
  thunderstorm,
  heavyRain,
  lightRain,
  showers,
  heavyCloud,
  lightCloud,
  clear,
  unknown
}

class Weathers extends Equatable {
  final Coord coord;
  final List<Weather> weather;
  final String base;
  final Main main;
  final Wind wind;
  final Clouds clouds;
  var dt;
  final Sys sys;
  var id;
  final String name;
  var cod;

  Weathers({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.id,
    this.name,
    this.cod
  }) : super([
    coord,
    weather,
    base,
    main,
    wind,
    clouds,
    dt,
    sys,
    id,
    name,
    cod
  ]);

  static Weathers fromJson(Map<String, dynamic> json) {
    var list = json['weather'] as List;
    final weatherList = list.map((i) => Weather.fromJson(i)).toList();

    return Weathers(
        coord: Coord.fromJson(json['coord']),
        weather: weatherList,
        base: json['base'],
        main: Main.fromJson(json['main']),
        wind: Wind.fromJson(json['wind']),
        clouds: Clouds.fromJson(json['clouds']),
        dt: json['dt'],
        sys: Sys.fromJson(json['sys']),
        id: json['id'],
        name: json['name'],
        cod: json['cod']);
  }
}

class Coord extends Equatable {
  final double lat, lon;

  Coord({
    this.lat,
    this.lon,
  }) : super([
    lat,
    lon
  ]);

  factory Coord.fromJson(Map<String, dynamic> json) =>
      Coord(
        lon: json['lon'],
        lat: json['lat'],
      );

}

class Weather {
  var id;
  String main;
  String description;
  String icon;

  Weather({this.id, this.main, this.description, this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) =>
      Weather(
        id: json['id'],
        main: json['main'],
        description: json['description'],
        icon: json['icon'],
      );

  @override
  String toString() => '{id: $id, main: $main, description: $description, icon: $icon}';
}


class Main {
  var temp;
  var pressure;
  var humidity;
  var temp_min;
  var temp_max;

  Main({this.temp, this.pressure, this.humidity, this.temp_min, this.temp_max});

  factory Main.fromJson(Map<String, dynamic> json) =>
      Main(
        temp: json['temp'] - 273.15,
        pressure: json['pressure'],
        humidity: json['humidity'],
        temp_min: json['temp_min'] - 273.15,
        temp_max: json['temp_max'] - 273.15,
      );

  @override
  String toString() => '{temp: $temp, pressure: $pressure, humidity: $humidity, temp_min: $temp_min, temp_max: $temp_max}';
}

class Wind {
  var speed;
  var deg;

  Wind({this.speed, this.deg});

  factory Wind.fromJson(Map<String, dynamic> json) =>
      Wind(
        speed: json['speed'],
        deg: json['deg'],
      );

  @override
  String toString() => '{speed: $speed, deg: $deg}';
}

class Clouds {
  var all;

  Clouds({this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) =>
      Clouds(
        all: json['all'],
      );

  @override
  String toString() => '{all: $all}';
}

class Rain {
  final double hour3;

  Rain({this.hour3});

  factory Rain.fromJson(Map<String, dynamic> json) =>
      Rain(
        hour3: json['hour3'],
      );

  @override
  String toString() => '{3h: $hour3}';
}

class Sys {
  var type;
  var id;
  var message;
  String country;
  var sunrise;
  var sunset;

  Sys({this.type,
    this.id,
    this.message,
    this.country,
    this.sunrise,
    this.sunset});

  factory Sys.fromJson(Map<String, dynamic> json) =>
      Sys(
        type: json['type'],
        id: json['id'],
        message: json['message'],
        country: json['country'],
        sunrise: json['sunrise'],
        sunset: json['sunset'],
      );

  @override
  String toString() =>
      'Sys: {type: $type, id: $id, message: $message, country: $country, sunrise: $sunrise, sunset: $sunset}';
}

/*
class Weather extends Equatable {
  final WeatherCondition condition;
  final String formattedCondition;
  final double minTemp;
  final double temp;
  final double maxTemp;
  final int locationId;
  final String created;
  final DateTime lastUpdated;
  final String location;

  Weather({
    this.condition,
    this.formattedCondition,
    this.minTemp,
    this.temp,
    this.maxTemp,
    this.locationId,
    this.created,
    this.lastUpdated,
    this.location,
  }) : super([
    condition,
    formattedCondition,
    minTemp,
    temp,
    maxTemp,
    locationId,
    created,
    lastUpdated,
    location,
  ]);

  static Weather fromJson(dynamic json) {
    final consolidatedWeather = json['consolidated_weather'][0];
    return Weather(
      condition: _mapStringToWeatherCondition(
          consolidatedWeather['weather_state_abbr']),
      formattedCondition: consolidatedWeather['weather_state_name'],
      minTemp: consolidatedWeather['min_temp'] as double,
      temp: consolidatedWeather['the_temp'] as double,
      maxTemp: consolidatedWeather['max_temp'] as double,
      locationId: json['woeid'] as int,
      created: consolidatedWeather['created'],
      lastUpdated: DateTime.now(),
      location: json['title'],
    );
  }

  static WeatherCondition _mapStringToWeatherCondition(String input) {
    WeatherCondition state;
    switch (input) {
      case 'sn':
        state = WeatherCondition.snow;
        break;
      case 'sl':
        state = WeatherCondition.sleet;
        break;
      case 'h':
        state = WeatherCondition.hail;
        break;
      case 't':
        state = WeatherCondition.thunderstorm;
        break;
      case 'hr':
        state = WeatherCondition.heavyRain;
        break;
      case 'lr':
        state = WeatherCondition.lightRain;
        break;
      case 's':
        state = WeatherCondition.showers;
        break;
      case 'hc':
        state = WeatherCondition.heavyCloud;
        break;
      case 'lc':
        state = WeatherCondition.lightCloud;
        break;
      case 'c':
        state = WeatherCondition.clear;
        break;
      default:
        state = WeatherCondition.unknown;
    }
    return state;
  }

  static Weather fromFileJson(dynamic json) {
    return Weather(
      condition: _mapStringToWeatherCondition(
          json['weather_state_abbr']),
      formattedCondition: json['weather_state_name'],
      minTemp: json['min_temp'] as double,
      temp: json['the_temp']  as double,
      maxTemp: json['max_temp']  as double,
      locationId: json['woeid'] as int,
      created: json['created'],
      location: json['title'],
    );

  }

  Map<String, Object> toJson() {
    return {
      "weather_state_name": formattedCondition,
      "min_temp": minTemp,
      "the_temp": temp,
      "max_temp": maxTemp,
      "woeid": locationId,
      "created":created,
      "title":location,

    };
  }

}
*/