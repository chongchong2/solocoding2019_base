import 'package:meta/meta.dart';
import 'package:solocoding2019_base/models/weather_model.dart';
import 'package:solocoding2019_base/repositories/weather_api_client.dart';


class WeatherRepository {
  final WeatherApiClient weatherApiClient;

  WeatherRepository({@required this.weatherApiClient})
      : assert(weatherApiClient != null);

  Future<Weather> getWeather(String city) async {
    final int locationId = await weatherApiClient.getLocationId(city);
    return await weatherApiClient.fetchWeather(locationId);
  }
}
