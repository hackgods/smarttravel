import 'dart:convert';
import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:smarttravel/animations/fadeanimation.dart';
import 'package:smarttravel/models/placesmodel.dart';
import 'package:smarttravel/screens/details.dart';


class TouristPlaceNearby extends StatefulWidget {
  const TouristPlaceNearby({Key key}) : super(key: key);

  @override
  _TouristPlaceNearbyState createState() => _TouristPlaceNearbyState();
}

class _TouristPlaceNearbyState extends State<TouristPlaceNearby> {

  List<Touristmodel> listTourists;
  bool loading = true;

  loaddata() async {
    var placesdata = await rootBundle.loadString('assets/touristplaces.json');
    var decodeData = jsonDecode(placesdata);
    listTourists = List.from(decodeData).map<Touristmodel>((tourist) => Touristmodel.fromMap(tourist)).toList();
    print(listTourists[0].name);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    loaddata();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0,bottom: 20.0),
      child: loading != true ? CarouselSlider(
        options: CarouselOptions(
            height: 450.0,
            aspectRatio: 16/9,
            viewportFraction: 0.8,
            enlargeCenterPage: true,
            pageSnapping: true,
          autoPlay: true,
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayInterval: Duration(seconds: 3),
        ),
        items: listTourists.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Details(name: i.name,desc: i.desc,img: i.imagePath,loc: [i.latlng[0],i.latlng[1]],)),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: FadeAnimation(
                    0.2, AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: Offset(0, 10)
                            )
                          ]
                      ),
                      child: Stack(
                        children: [
                          Hero(
                            tag: i.name,
                            child: Container(
                              height: 450,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ShaderMask(
                                      shaderCallback: (rect) {
                                        return LinearGradient(
                                          begin: Alignment.center,
                                          end: Alignment.bottomCenter,
                                          colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                                        ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                                      },
                                      blendMode: BlendMode.darken,
                                      child: Image.network(i.imagePath, fit: BoxFit.cover)),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              decoration: BoxDecoration(
                                 // color: Colors.white.withOpacity(0.0),
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                              ),
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(i.name, style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    color: Colors.white
                                  ),),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ),
                  ),
                ),
              );
            },
          );
        }).toList(),
      ) : SizedBox(),
    );
  }
}
