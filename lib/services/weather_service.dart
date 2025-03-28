import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {

  // ignore: constant_identifier_names
  static const BASE_URL = 'http://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
  //Future<Weather> getWeather(String zipCode, countryCode) async {
    final response = await http.get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));
    //final response = await http.get(Uri.parse('$BASE_URL?zip=$zipCode,$countryCode&appid=$apiKey&units=metric'));
    //https:api.openweathermap.org/data/2.5/weather?zip={zip code},{country code}&appid={API key}

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  } 
  Future<String> getCurrentCity() async {

    //get permission from user
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    //fetch the location 
    Position position = await Geolocator.getCurrentPosition(
      // ignore: deprecated_member_use
      desiredAccuracy: LocationAccuracy.high);

    //convert the location into a list of placemark objects
    //List<Placemark> placemarks = await placemarkFromCoordinates(46.9659, 31.9974);
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    //To run your location in simulator: go Features->Location->Custom location and input your data

    //extract the city name from the first placemark
    String? city = placemarks[0].locality;

    return city ?? ""; 
  }

}