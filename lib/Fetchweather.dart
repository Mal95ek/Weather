import 'package:flutter/material.dart';
import 'package:flutterapi/WeatherClass.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';

class FetchWeathers with ChangeNotifier {
  final List<InfoWeather> loadedWeather = [];
  Future<List<InfoWeather>> fetchData() async {
    User weatherData = FirebaseAuth.instance.currentUser;
    const url =
        "https://waetherapp-d7753-default-rtdb.firebaseio.com/WeatherData.json";
    try {
      final res = await http.get(url);
      print(res);
      final extractedData = jsonDecode(res.body) as Map<String, dynamic>;
      print(extractedData);
      extractedData.forEach((weatherId, weatherData) {
        loadedWeather.add(InfoWeather(
          name: weatherData['name'].toString(),
          base: weatherData['base'].toString(),
          main: Main(
              temp: weatherData['temp'], humidity: weatherData['humdetity']),
          dt: weatherData['dt'],
        ));
      });
      notifyListeners();
    } catch (error) {
      throw error;
    }
    return loadedWeather;
  }
}
