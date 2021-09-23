import 'dart:convert';

import 'package:flutter/services.dart';

class City {
  City({
    required this.id,
    required this.name,
    required this.state,
    required this.country,
    required this.coord,
  });

  int id;
  String name;
  String state;
  String country;
  Coord coord;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        state: json["state"],
        coord: Coord.fromJson(json["coord"]),
        country: json['country'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "state": state,
        "country": countryValues.reverse[country],
        "coord": coord.toJson(),
      };
}

class Coord {
  Coord({
    required this.lon,
    required this.lat,
  });

  double lon;
  double lat;

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lon: json["lon"].toDouble(),
        lat: json["lat"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lon": lon,
        "lat": lat,
      };
}

enum Country { JO }
final countryValues = EnumValues({"JO": Country.JO});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);
  Map<T, String> get reverse {
    // ignore: unnecessary_null_comparison
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

Future<List<City>> readJsoncitises() async {
  final jsondata = await rootBundle.loadString('assets/jordan_cities.json');

  final list = jsonDecode(jsondata) as List<dynamic>;
  return list.map((e) => City.fromJson(e)).toList();
}
