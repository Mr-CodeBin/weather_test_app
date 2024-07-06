import 'package:flutter/material.dart';

class WeatherTheme {
  static String getWeatherBackground(String condition) {
    switch (condition) {
      case 'clear sky':
        return 'assets/images/clear_sky.png';
      case 'few clouds':
        return 'assets/images/few_clouds.png';
      case 'scattered clouds':
        return 'assets/images/scattered_clouds.png';
      case 'broken clouds':
        return 'assets/images/broken_clouds.png';
      case 'shower rain':
        return 'assets/images/shower_rain.png';
      case 'rain':
        return 'assets/images/rain.png';
      case 'thunderstorm':
        return 'assets/images/thunderstorm.png';
      case 'snow':
        return 'assets/images/snow.png';
      case 'mist':
        return 'assets/images/mist.png';
      default:
        return 'assets/images/default.png';
    }
  }

  static Color getWeatherTextColor(String condition) {
    switch (condition) {
      case 'clear sky':
        return Colors.white;
      case 'few clouds':
        return Colors.white;
      case 'scattered clouds':
        return Colors.white;
      case 'broken clouds':
        return Colors.white;
      case 'shower rain':
        return Colors.white;
      case 'rain':
        return Colors.white;
      case 'thunderstorm':
        return Colors.white;
      case 'snow':
        return Colors.black;
      case 'mist':
        return Colors.black;
      default:
        return Colors.white;
    }
  }
}
