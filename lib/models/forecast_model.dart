import 'package:equatable/equatable.dart';
import 'package:solocoding2019_base/models/weather_model.dart';

class ForecastWeathers extends Equatable {
  final cod;
  final message;
  final cnt;
  List<Forecast> forecastList;

  ForecastWeathers({this.cod, this.message, this.cnt, this.forecastList})
      : super([cod, message, cnt, forecastList]);

  static ForecastWeathers fromJson(Map<String, dynamic> json) {
    var datalist = json['list'] as List;

    List<Forecast> data = [];

    datalist.forEach((el) {
      var sublist = Forecast.fromJson(el);
      data.add(sublist);
    });

    return ForecastWeathers(
        cod: json['cod'],
        message: json['message'],
        cnt: json['cnt'],
        forecastList: data);
  }
}

class Forecast {
  int dt;
  final ForecastMain main;
  final List<ForecastWeather> weather;
  final Clouds clouds;

  String dtTxt;

  Forecast({this.dt, this.main, this.weather, this.clouds, this.dtTxt});

  factory Forecast.fromJson(dynamic json) {
    final list = json['weather'] as List;
    final weatherList = list.map((i) => ForecastWeather.fromJson(i)).toList();

    return Forecast(
        dt: json['dt'],
        main: ForecastMain.fromJson(json['main']),
        weather: weatherList,
        clouds: Clouds.fromJson(json['clouds']),
        dtTxt: json['dt_txt']);
  }
}

class ForecastMain {
  var temp;
  var pressure;
  var humidity;
  var temp_min;
  var temp_max;
  var sea_level;
  var grnd_level;
  var temp_kf;

  ForecastMain(
      {this.temp,
      this.pressure,
      this.humidity,
      this.temp_min,
      this.temp_max,
      this.sea_level,
      this.grnd_level,
      this.temp_kf});

  factory ForecastMain.fromJson(Map<String, dynamic> json) => ForecastMain(
      temp: json['temp'] - 273.15,
      pressure: json['pressure'],
      humidity: json['humidity'],
      temp_min: json['temp_min'] - 273.15,
      temp_max: json['temp_max'] - 273.15,
      sea_level: json['sea_level'],
      grnd_level: json['grnd_level'],
      temp_kf: json['temp_kf']);
}

class ForecastWeather {
  var id;
  var main;
  var description;
  var icon;

  ForecastWeather({this.id, this.main, this.description, this.icon});

  factory ForecastWeather.fromJson(Map<String, dynamic> json) {
    return ForecastWeather(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}

class ForecastSys {
  var pod;

  ForecastSys({this.pod});

  factory ForecastSys.fromJson(Map<String, dynamic> json) => ForecastSys(
        pod: json['pod'],
      );
}
