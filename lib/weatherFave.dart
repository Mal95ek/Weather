import 'package:flutter/material.dart';
import 'package:flutterapi/WeatherClass.dart';

// ignore: must_be_immutable
class WeatherFave extends StatelessWidget {
  late List<InfoWeather> faverteSave = [];
  WeatherFave(List<InfoWeather> faverteSave) {
    this.faverteSave = faverteSave;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white70,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
        backgroundColor: Color(0xff064969),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: faverteSave.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Image.asset(
                    'assets/weatherpage.jpg',
                    height: 200,
                    width: 100,
                  ),
                  Center(
                      child: Text(
                          ' thisIsIdCity   ${faverteSave[index].id.toString()}')),
                  Center(
                      child: Text(
                          'thisIsNameCity     ${faverteSave[index].name}')),
                  Center(
                      child: Text(
                          ' Temp       ${faverteSave[index].main!.temp.toString()}')),
                  Center(
                      child: Text(
                          'Humidity    ${faverteSave[index].main!.humidity.toString()}')),
                  Center(
                      child:
                          Text('dtcity  ${faverteSave[index].dt.toString()}')),
                  Divider()
                ],
              );
            }));
  }
}
