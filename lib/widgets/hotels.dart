import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarttravel/animations/fadeanimation.dart';
import 'package:smarttravel/models/hotelmodel.dart';
import 'package:glass_kit/glass_kit.dart';

class HotelsScreen extends StatefulWidget {
  const HotelsScreen({Key key}) : super(key: key);

  @override
  _HotelsScreenState createState() => _HotelsScreenState();
}

class _HotelsScreenState extends State<HotelsScreen> {

  List<Hotelmodel> listHotels;
  bool loading = true;

  loaddata() async {
    var placesdata = await rootBundle.loadString('assets/hotels.json');
    var decodeData = jsonDecode(placesdata);
    listHotels = List.from(decodeData).map<Hotelmodel>((tourist) => Hotelmodel.fromMap(tourist)).toList();
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
          height: 250.0,
          aspectRatio: 16/9,
          viewportFraction: 0.85,
          enlargeCenterPage: true,
          pageSnapping: true,
          autoPlay: true,
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayInterval: Duration(seconds: 3),
        ),
        items: listHotels.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {

                 /* Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Details(name: i.name,desc: i.desc,img: i.imagePath,loc: [i.latlng[0],i.latlng[1]],)),
                  );
                  */
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
                              height: 250,
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
                                  child: Image.network(i.image1, fit: BoxFit.cover,width: MediaQuery.of(context).size.width,)),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GlassContainer(
                                borderRadius: BorderRadius.circular(10.0),
                                height: 35,
                                width: 100,
                                gradient: LinearGradient(
                                  colors: [Colors.white.withOpacity(0.30), Colors.white.withOpacity(0.10)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderColor: Colors.transparent,
                                blur: 15.0,
                                borderWidth: 0.1,
                                elevation: 3.0,
                                isFrostedGlass: true,
                                shadowColor: Colors.black.withOpacity(0.20),
                                alignment: Alignment.center,
                                frostedOpacity: 0.12,
                                padding: EdgeInsets.all(8.0),
                                child: Text("₹ " + i.price, style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black.withOpacity(0.8)
                                ),),
                              ),
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
