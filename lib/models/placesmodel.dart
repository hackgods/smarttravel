// To parse this JSON data, do
//
//     final touristmodel = touristmodelFromMap(jsonString);

import 'dart:convert';

List<Touristmodel> touristmodelFromMap(String str) => List<Touristmodel>.from(json.decode(str).map((x) => Touristmodel.fromMap(x)));

String touristmodelToMap(List<Touristmodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Touristmodel {
  Touristmodel({
    this.name,
    this.desc,
    this.imagePath,
    this.colors,
    this.latlng,
  });

  String name;
  String desc;
  String imagePath;
  List<Color> colors;
  List<double> latlng;

  factory Touristmodel.fromMap(Map<String, dynamic> json) => Touristmodel(
    name: json["name"],
    desc: json["desc"],
    imagePath: json["imagePath"],
    colors: List<Color>.from(json["colors"].map((x) => colorValues.map[x])),
    latlng: List<double>.from(json["latlng"].map((x) => x.toDouble())),
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "desc": desc,
    "imagePath": imagePath,
    "colors": List<dynamic>.from(colors.map((x) => colorValues.reverse[x])),
    "latlng": List<dynamic>.from(latlng.map((x) => x)),
  };
}

enum Color { COLOR_0_X_FFA70042, COLOR_0_X_FF004_C99 }

final colorValues = EnumValues({
  "Color(0xFF004C99)": Color.COLOR_0_X_FF004_C99,
  "Color(0xFFA70042)": Color.COLOR_0_X_FFA70042
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
