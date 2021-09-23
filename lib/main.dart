// ignore: unused_import
import 'dart:convert';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterapi/Fetchweather.dart';
import 'package:flutterapi/weatherDeatils.dart';
import 'jsonCities.dart';
import 'weatherFave.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MainPage());
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Container(
            padding: EdgeInsets.only(top: 20),
            child: SplashScreen(
              seconds: 6,
              navigateAfterSeconds: new JsonCountery(),
              title: new Text(
                'Done by Malek Bawadi',
                textScaleFactor: 2,
              ),
              image: new Image.asset(
                'assets/weatherpage.jpg',
              ),
              photoSize: 100,
              loaderColor: Colors.blue,
            )));
  }
}

class JsonCountery extends StatefulWidget {
  @override
  _JsonCounteryState createState() => _JsonCounteryState();
}

class _JsonCounteryState extends State<JsonCountery> {
  @override
  void initState() {
    Firebase.initializeApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          actions: [
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                FetchWeathers().fetchData().then((value) => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WeatherFave(value)),
                      ),
                    });
              },
            ),
          ],
          centerTitle: true,
          title: Text(
            'Weather Screen ',
            style: TextStyle(),
          ),
        ),
        body: Container(
          color: Colors.white70,
          child: FutureBuilder(
              future: readJsoncitises(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('${snapshot.error}'));
                } else if (snapshot.hasData) {
                  List<City> data = snapshot.data as List<City>;
                  return ListView.builder(
                      itemBuilder: (BuildContext context, index) {
                    return Container(
                        color: Colors.white,
                        height: 80,
                        child: Card(
                          color: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          elevation: 5,
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          child: InkWell(
                            child: Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                data[index].name.toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        WeatherDetailedPage(data[index].id)),
                              );
                            },
                          ),
                        ));
                  });
                } else
                  return Center(
                    child: CircularProgressIndicator(),
                  );
              }),
        ));
  }
}
