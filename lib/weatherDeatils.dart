import 'dart:convert';

import 'package:flutter/material.dart';
import 'WeatherClass.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class WeatherDetailedPage extends StatelessWidget {
  int cityid;
  WeatherDetailedPage(this.cityid);
  late InfoWeather infoWeatheDetilsSaveFirebase;
  void saveMessage(
    id,
    String name,
    double temp,
    int humdetity,
    int? dt,
  ) {
    final String url =
        'https://waetherapp-d7753-default-rtdb.firebaseio.com//WeatherData.json';
    http.post(url,
        body: jsonEncode({
          'id': id,
          'name': name,
          'tmep': temp,
          'humdetity': humdetity,
          'dt': dt
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Detailed Information'),
          actions: [
            Container(
              child: IconButton(
                icon: Icon(Icons.favorite),
                onPressed: () {
                  final snackBar = SnackBar(
                    content: const Text('SAVE Data !'),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        // Some code to undo the change.
                      },
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  saveMessage(
                    this.infoWeatheDetilsSaveFirebase.id,
                    this.infoWeatheDetilsSaveFirebase.name,
                    this.infoWeatheDetilsSaveFirebase.main!.temp,
                    this.infoWeatheDetilsSaveFirebase.main!.humidity,
                    this.infoWeatheDetilsSaveFirebase.dt,
                  );
                },
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/background.jpeg'),
                      fit: BoxFit.cover)),
            ),
            Stack(
              children: [
                ListView(
                  children: [
                    FutureBuilder(
                      future: getweather(cityid),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError)
                          return Center(
                            child: Text('${snapshot.error} has occurred.'),
                          );
                        else if (snapshot.hasData) {
                          final InfoWeather weatherInfromation =
                              snapshot.data as InfoWeather;
                          this.infoWeatheDetilsSaveFirebase =
                              weatherInfromation;
                          return Container(
                              height: 600,
                              width: 550,
                              padding: EdgeInsets.only(top: 30),
                              child: Column(children: [
                                Text(
                                  'Weather Infromation',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 30),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Card(
                                  color: Colors.white70,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  elevation: 80,
                                  child: TextField(
                                    decoration: InputDecoration(
                                        labelText:
                                            'Tempurture(F) ${weatherInfromation.main!.temp.toString()}',
                                        labelStyle: TextStyle(wordSpacing: 70)),
                                  ),
                                ),
                                Card(
                                  color: Colors.lightBlue,
                                  elevation: 80,
                                  shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        labelText:
                                            'CityID ${weatherInfromation.id.toString()}',
                                        labelStyle:
                                            TextStyle(wordSpacing: 115)),
                                  ),
                                ),
                                Card(
                                  shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  color: Colors.blueGrey,
                                  elevation: 10,
                                  child: TextField(
                                    decoration: InputDecoration(
                                        labelText:
                                            'Cityname ${weatherInfromation.name}',
                                        labelStyle:
                                            TextStyle(wordSpacing: 100)),
                                  ),
                                ),
                                Card(
                                  shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  color: Colors.deepOrange,
                                  elevation: 10,
                                  child: TextField(
                                    decoration: InputDecoration(
                                        labelText:
                                            'Humidity ${weatherInfromation.main!.humidity.toString()}',
                                        labelStyle:
                                            TextStyle(wordSpacing: 110)),
                                  ),
                                ),
                                Card(
                                  color: Colors.white70,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  elevation: 80,
                                  child: TextField(
                                    decoration: InputDecoration(
                                        labelText:
                                            'DtCity ${weatherInfromation.dt.toString()}',
                                        labelStyle:
                                            TextStyle(wordSpacing: 100)),
                                  ),
                                ),
                              ]));
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ],
                )
              ],
            )
          ],
        ));
  }
}
