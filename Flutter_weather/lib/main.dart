import 'package:flutter/material.dart';
import 'package:flutter_weather/pages/weather_page.dart';

//install cocoapods - https://github.com/CocoaPods/CocoaPods/issues/12145

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherPage(),
    );
  }
}
