import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_test_app/controllers/weather_provider.dart';
import 'package:weather_test_app/models/weather_data_model.dart';
import 'package:weather_test_app/screens/glass_widget.dart';
import 'package:weather_test_app/screens/weather_theme.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _cityController = TextEditingController();
  HomeScreen({super.key});

  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = date.difference(now);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else {
      if (diff.inDays == 1) {
        time = '${diff.inDays}DAY AGO';
      } else {
        time = '${diff.inDays}DAYS AGO';
      }
    }

    //convert time to 12 hours format
    time = DateFormat.jm().format(date);

    return time;
  }

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherProvider>(context).weatherData;
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return SafeArea(
      child: Consumer<WeatherProvider>(
        builder: (BuildContext context, WeatherProvider value, Widget? child) {
          if (weatherProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (weatherProvider.errorMessage != null) {
            return Center(child: Text(weatherProvider.errorMessage!));
          }

          if (weatherData == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        opacity: Theme.of(context).brightness == Brightness.dark
                            ? 0.5
                            : 1.2,
                        image: AssetImage(
                          WeatherTheme.getWeatherBackground(
                              weatherData.condition),
                        ),
                        fit: BoxFit.fitHeight,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5),
                          BlendMode.darken,
                        ),
                      ),
                    ),
                  ),
                ),
                secondPage(context, weatherData, weatherProvider),
              ],
            ),
          );
        },
      ),
    );
  }

  Column secondPage(BuildContext context, WeatherData weatherData,
      WeatherProvider weatherProvider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: IconButton(
                onPressed: () {
                  //exit app but ask for confirmation first
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.black.withOpacity(0.9),
                      title: const Text(
                        'Exit App',
                        style: TextStyle(color: Colors.white),
                      ),
                      content: const Text(
                        'Are you sure you want to exit?',
                        style: TextStyle(color: Colors.white),
                      ),
                      actions: [
                        TextButton(
                          style: ButtonStyle(
                            shape: MaterialStatePropertyAll<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            backgroundColor: MaterialStatePropertyAll<Color>(
                              Colors.black54,
                            ),
                            // foregroundColor:
                            //     MaterialStateProperty.all<Color>(Colors.white),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('No'),
                        ),
                        TextButton(
                          style: ButtonStyle(
                            shape: MaterialStatePropertyAll<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            backgroundColor: MaterialStatePropertyAll<Color>(
                              Colors.black54,
                            ),
                            // foregroundColor:
                            //     MaterialStateProperty.all<Color>(Colors.white),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            SystemNavigator.pop();
                          },
                          child: const Text('Yes'),
                        ),
                      ],
                    ),
                  );
                },
                icon: Icon(
                  Icons.arrow_back,
                  color:
                      WeatherTheme.getWeatherTextColor(weatherData.condition),
                ),
                iconSize: MediaQuery.of(context).size.width * 0.08,
              ),
            ),

            //show the city name
            Text(
              weatherData.cityName,
              style: GoogleFonts.notoSansSc(
                fontSize: MediaQuery.of(context).size.width * 0.06,
                fontWeight: FontWeight.bold,
                color: WeatherTheme.getWeatherTextColor(weatherData.condition),
              ),
            ),
          ],
        ),

        //text field for searching city
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _cityController,
                  style: GoogleFonts.notoSansSc(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontWeight: FontWeight.w500,
                    color: WeatherTheme.getWeatherTextColor(
                      weatherData.condition,
                    ),
                  ),
                  decoration: InputDecoration(
                    labelText: 'Enter city name',
                    labelStyle: GoogleFonts.notoSansSc(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: WeatherTheme.getWeatherTextColor(
                          weatherData.condition,
                        )),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(
                        color: WeatherTheme.getWeatherTextColor(
                          weatherData.condition,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  if (_cityController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter a city name'),
                      ),
                    );
                    return;
                  }
                  Provider.of<WeatherProvider>(context, listen: false)
                      .getWeather(_cityController.text);
                },
                icon: Icon(
                  Icons.search,
                  color:
                      WeatherTheme.getWeatherTextColor(weatherData.condition),
                ),
                iconSize: 32,
              ),
            ],
          ),
        ),
        Spacer(),

        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              weatherData.cityName,
              style: GoogleFonts.notoSansSc(
                fontSize: MediaQuery.of(context).size.width * 0.19,
                fontWeight: FontWeight.w500,
                color: WeatherTheme.getWeatherTextColor(weatherData.condition),
              ),
            ),
            Text(
              '${weatherData.temperature.toInt()}°c',
              style: GoogleFonts.notoSansSc(
                fontSize: MediaQuery.of(context).size.width * 0.15,
                fontWeight: FontWeight.w500,
                color: WeatherTheme.getWeatherTextColor(weatherData.condition),
              ),
            ),
            Text(
              weatherData.condition,
              style: GoogleFonts.notoSansSc(
                fontSize: MediaQuery.of(context).size.width * 0.06,
                fontWeight: FontWeight.w500,
                color: WeatherTheme.getWeatherTextColor(weatherData.condition),
              ),
            ),
          ],
        ),
        // SizedBox(
        //   width: MediaQuery.of(context).size.width * 0.2,
        //   child: Image.network(
        //     'http://openweathermap.org/img/wn/${weatherData.icon}@2x.png',
        //     color: WeatherTheme.getWeatherTextColor(weatherData.condition),
        //   ),
        // ),

        // SizedBox(height: MediaQuery.of(context).size.height * 0.179),
        Spacer(),

        //glass container
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GlassContainer(
              weatherData: weatherData,
              weatherIcon: Iconsax.wind,
              attribute: weatherData.windSpeed.toString(),
              unit: ' m/s',
              weatherAttribute: 'Wind',
            ),
            GlassContainer(
              weatherData: weatherData,
              weatherIcon: Iconsax.cloud_fog,
              attribute: weatherData.humidity.toString(),
              unit: ' %',
              weatherAttribute: 'Humidity',
            ),
            GlassContainer(
              weatherData: weatherData,
              attribute: weatherData.pressure.toString(),
              weatherIcon: Iconsax.eye,
              unit: ' hPa',
              weatherAttribute: 'Pressure',
            ),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GlassContainer(
              weatherData: weatherData,
              weatherIcon: Iconsax.sun_1,
              attribute: readTimestamp(weatherData.sunrise),
              unit: '',
              weatherAttribute: 'Sunrise',
            ),
            GlassContainer(
              weatherData: weatherData,
              weatherIcon: Iconsax.moon,
              attribute: readTimestamp(weatherData.sunset),
              unit: '',
              weatherAttribute: 'Sunset',
            ),
          ],
        ),
        //
      ],
    );
  }
}
