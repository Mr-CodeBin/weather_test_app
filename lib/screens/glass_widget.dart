import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_test_app/models/weather_data_model.dart';
import 'package:weather_test_app/screens/weather_theme.dart';

class GlassContainer extends StatelessWidget {
  const GlassContainer({
    super.key,
    required this.weatherData,
    required this.attribute,
    required this.weatherIcon,
    required this.unit,
    required this.weatherAttribute,
  });

  final WeatherData weatherData;
  final String attribute;
  final IconData weatherIcon;
  final String unit;
  final String weatherAttribute;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(
                    weatherIcon,
                    color: WeatherTheme.getWeatherTextColor(
                      weatherData.condition,
                    ),
                    size: MediaQuery.of(context).size.width * 0.09,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        attribute,
                        style: GoogleFonts.notoSansSc(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: WeatherTheme.getWeatherTextColor(
                            weatherData.condition,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          unit,
                          style: GoogleFonts.notoSansSc(
                            // fontSize:
                            //     MediaQuery.of(context).size.width * 0.032,
                            color: WeatherTheme.getWeatherTextColor(
                              weatherData.condition,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    weatherAttribute,
                    style: GoogleFonts.notoSansSc(
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      color: WeatherTheme.getWeatherTextColor(
                        weatherData.condition,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
