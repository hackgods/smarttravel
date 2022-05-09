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
    this.img,
    this.latlng,
  });

  String name;
  String desc;
  int rating;
  String price;
  String size;
  List<String> img;
  List<double> latlng;

  factory Hotelmodel.fromMap(Map<String, dynamic> json) => Hotelmodel(
    name: json["name"],
    desc: json["desc"],
    rating: json["rating"],
    price: json["price"],
    size: json["size"],
    img: List<String>.from(json["img"].map((x) => x)),
    latlng: List<double>.from(json["latlng"].map((x) => x.toDouble())),
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "desc": desc,
    "rating": rating,
    "price": price,
    "size": size,
    "img": List<dynamic>.from(img.map((x) => x)),
    "latlng": List<dynamic>.from(latlng.map((x) => x)),
  };
}
