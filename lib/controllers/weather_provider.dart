import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_test_app/models/weather_data_model.dart';

import 'package:weather_test_app/services/weather_service.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherService _weatherService = WeatherService();
  WeatherData? _weatherData;
  String _lastSearchCity = '';
  bool isLoading = false;
  String? errorMessage;

  WeatherData? get weatherData => _weatherData;
  String get lastSearchCity => _lastSearchCity;

  WeatherProvider() {
    _loadLastSearchedCity();
  }

  Future<void> getWeather(String cityName) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      _weatherData = await _weatherService.fetchWeatherData(cityName);

      await _saveLastSearchedCity(cityName);
    } catch (e) {
      errorMessage = e.toString();

      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => ErrorScreen(),
      //   ),
      // );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _saveLastSearchedCity(String cityName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_city', cityName);
  }

  Future<void> _loadLastSearchedCity() async {
    final prefs = await SharedPreferences.getInstance();
    final lastCity = prefs.getString('last_city');

    await Future.delayed(const Duration(seconds: 1));
    if (lastCity != null) {
      _lastSearchCity = lastCity;
      notifyListeners();

      await getWeather(lastCity);
    }
  }
}
