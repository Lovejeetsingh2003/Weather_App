import 'package:check_weather/model/weather_model.dart';
import 'package:check_weather/service/weather_service.dart';
import 'package:check_weather/theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final weatherService = WeatherService('5253e73cdd538ecad6971b7c62651d6f');

  WeatherModel? weatherModel;

  fetchWeather() async {
    String cityName = await weatherService.getCurrentCity();

    try {
      final weather = await weatherService.getWeather(cityName);

      setState(() {
        weatherModel = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    switch (mainCondition?.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              color: Theme.of(context).colorScheme.primary,
              size: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                weatherModel?.cityName ?? "Loading City....",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            Lottie.asset(getWeatherAnimation(weatherModel?.mainCondition)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "${weatherModel?.temperature.round()}°C",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            Text(
              weatherModel?.mainCondition ?? "",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
