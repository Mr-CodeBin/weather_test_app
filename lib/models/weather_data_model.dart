class WeatherData {
  final String cityName;
  final double temperature;
  final String condition;
  final String icon;
  final int humidity;
  final double windSpeed;

  final int sunrise;
  final int sunset;
  final double feelsLike;
  final int pressure;
  final int visibility;
  final double dewPoint;
  final double uvi;
  final String country;

  WeatherData({
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
    required this.sunrise,
    required this.sunset,
    required this.feelsLike,
    required this.pressure,
    required this.visibility,
    required this.dewPoint,
    required this.uvi,
    required this.country,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      cityName: json['name'],
      temperature: json['main']['temp'],
      condition: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'],
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      feelsLike: json['main']['feels_like'],
      pressure: json['main']['pressure'],
      visibility: json['visibility'],
      dewPoint: json['main']['temp'],
      uvi: json['main']['temp'],
      country: json['sys']['country'],
    );
  }
}
