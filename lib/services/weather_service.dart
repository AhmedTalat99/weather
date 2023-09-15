import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather/models/weather_model.dart';

class WeatherService {
  String baseUrl = 'http://api.weatherapi.com/v1';
  String apiKey = 'b35d68cac2e44fe0a83171620230309';
  Future<WeatherModel?> getWeather({required String cityName}) async {
    WeatherModel? weather;
    try {
      Uri url = Uri.parse('$baseUrl/forecast.json?key=$apiKey&q=$cityName');
      http.Response response = await http.get(url);
      // decoding of data to be easy dealing with it
      Map<String, dynamic> data = jsonDecode(response.body);
      var jsonData = data['forecast']['forecastday'][0];

      WeatherModel weather = WeatherModel.fromJson(data);
    } catch (e) {
      print(e);
    }

    return weather;
  }
}
