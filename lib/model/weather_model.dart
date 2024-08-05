class WeatherModel {
  final String cityName;
  final double temperature;
  final String mainCondition;

  WeatherModel(
      {required this.cityName,
      required this.temperature,
      required this.mainCondition});

  factory WeatherModel.fromjson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temperature: json['main']['temp'],
      mainCondition: json['weather'][0]['main'],
    );
  }
}
