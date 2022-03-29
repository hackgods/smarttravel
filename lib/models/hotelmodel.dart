// To parse this JSON data, do
//
//     final hotelmodel = hotelmodelFromMap(jsonString);

import 'dart:convert';

List<Hotelmodel> hotelmodelFromMap(String str) => List<Hotelmodel>.from(json.decode(str).map((x) => Hotelmodel.fromMap(x)));

String hotelmodelToMap(List<Hotelmodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Hotelmodel {
  Hotelmodel({
    this.name,
    this.desc,
    this.rating,
    this.price,
    this.size,
    this.image1,
    this.image2,
    this.image3,
    this.latlng,
  });

  String name;
  String desc;
  String rating;
  String price;
  String size;
  String image1;
  String image2;
  String image3;
  List<double> latlng;

  factory Hotelmodel.fromMap(Map<String, dynamic> json) => Hotelmodel(
    name: json["name"],
    desc: json["desc"],
    rating: json["rating"],
    price: json["price"],
    size: json["size"],
    image1: json["image1"],
    image2: json["image2"],
    image3: json["image3"],
    latlng: List<double>.from(json["latlng"].map((x) => x.toDouble())),
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "desc": desc,
    "rating": rating,
    "price": price,
    "size": size,
    "image1": image1,
    "image2": image2,
    "image3": image3,
    "latlng": List<dynamic>.from(latlng.map((x) => x)),
  };
}
