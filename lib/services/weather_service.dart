import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
// import 'dart:convert';

import 'package:weather_test_app/models/weather_data_model.dart';

class WeatherService {
  final String apiKey = "Enter Your API KEY from OpenWeatherAPI";

  Future<WeatherData> fetchWeatherData(String cityName) async {
    final response = await http.Client().get(
      Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric",
      ),
    );

    //
    if (response.statusCode == 200) {
      log(response.body);
      return WeatherData.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load weather data");
    }
  }
}
