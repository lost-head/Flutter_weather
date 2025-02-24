import 'package:flutter/material.dart';
import 'package:flutter_weather/models/weather_model.dart';
import 'package:flutter_weather/services/weather_service.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  //api key 
  final _weatherService = WeatherService('21f6d793b2550ddcd738483ed78999eb');
  Weather? _weather;

  //fetch weather 
  _fetchWeather() async {
   // get the current city 
   String cityName = await _weatherService.getCurrentCity();

   // get weather for city
   try {
    final weather = await _weatherService.getWeather(cityName);
    setState(() { 
     _weather = weather;
   });

  }

  //any errors
  catch (e) {
    // ignore: avoid_print
    print(e);
  }
}
  //weather animations 
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sun.json'; //default sunny 

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':  
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sun.json';
      default:
        return 'assets/sun.json';     
    } 
  }

  //init state
  @override
  void initState() {
    super.initState();

    //fetch weather on startup 
    _fetchWeather();
  }

//Text("apple".toUpperCase())

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 40, 40, 40),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              IconData(
                0xe3ab, fontFamily: 'MaterialIcons'
              ),
              color: Colors.deepOrange,
              size: 24.0,
            ),
            //city name 
            Text((_weather?.cityName ?? "loading city..").toUpperCase(), 
            style: TextStyle(
              fontSize: 26,
              color:Color(0xFF6C6C6C),
              fontWeight: FontWeight.w800,
              )
            ), 

            //animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
        
            //temperature 
            Text('${_weather?.temperature.round()}°C',
            style: TextStyle(
              fontSize: 36,
              color: Color(0xFF6C6C6C),
              fontWeight: FontWeight.w800
              )),

            //weather condition 
            Text(_weather?.mainCondition ?? "",
            style: TextStyle(
              fontSize: 26,
              color: Color(0xFF6C6C6C),
              fontWeight: FontWeight.w800
              )
            )
          ],
          ),
      ), 
    );
  }
}