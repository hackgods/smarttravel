import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:simple_star_rating/simple_star_rating.dart';
import 'package:smarttravel/animations/fadeanimation.dart';
import 'package:smarttravel/widgets/screenconfig.dart';
import 'package:transparent_image/transparent_image.dart';

class HotelDetails extends StatefulWidget {
  final String name;
  final List imgs;
  final String desc;
  final String price;
  final double rating;
  final List loc;
  final String size;
  const HotelDetails({this.name,this.imgs,this.desc,this.loc,this.price,this.rating,this.size});



  @override
  _HotelDetailsState createState() => _HotelDetailsState();
}

class _HotelDetailsState extends State<HotelDetails> {

  Timer timer;
  String imageUrl;

  @override
  void initState() {
    super.initState();
    imageUrl = widget.imgs[0];
    int randomInt(int min, int max) {
      return Random().nextInt(max - min + 1) + min;
    }
    timer = Timer.periodic(
      const Duration(seconds: 3),
          (timer) {
        setState(() {
          imageUrl = widget.imgs[randomInt(0, 2)];
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Stack(
                  children: [
                        Hero(
                          tag: widget.name,
                          child: Container(
                            height: screenHeight(context)/1.7,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),

                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: imageUrl,
                              height: screenHeight(context)/1.5,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GlassContainer(
                            borderRadius: BorderRadius.circular(10.0),
                            height: screenHeight(context)/8,
                            width: screenWidth(context)/1.2,
                            gradient: LinearGradient(
                              colors: [Colors.white.withOpacity(0.30), Colors.white.withOpacity(0.10)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderColor: Colors.transparent,
                            blur: 20.0,
                            borderWidth: 0.1,
                            elevation: 4.0,
                            isFrostedGlass: true,
                            shadowColor: Colors.black.withOpacity(0.20),
                            alignment: Alignment.center,
                            frostedOpacity: 0.12,
                            padding: EdgeInsets.all(8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.name,
                                    style: GoogleFonts.poppins(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white.withOpacity(0.8)
                                    ),),

                                  SizedBox(height: 10,),



                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("₹ " + widget.price,
                                        style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            letterSpacing: 1.5,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white.withOpacity(0.8)
                                        ),),

                                      SimpleStarRating(
                                        allowHalfRating: true,
                                        starCount: 5,
                                        rating: widget.rating,
                                        isReadOnly: true,
                                        size: 22,
                                        spacing: 10,
                                      ),
                                    ],
                                  )

                                ],
                              ),
                            )
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: FadeAnimation(
                  0.3, Text(widget.desc,
                  style: GoogleFonts.poppins(color: Colors.black.withOpacity(0.7), fontSize: 16, height: 1.5),
                ),
                ),
              ),

            ],
          ),
        ),
      ),

      bottomNavigationBar: SafeArea (
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FadeAnimation(
                0.3, Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(widget.size + " @ " + "₹ " + widget.price,
                  style: GoogleFonts.poppins(color: Colors.black.withOpacity(0.7), fontSize: 16,fontWeight: FontWeight.w700),
              ),
                ),
              ),

              FadeAnimation(
                0.35, FlatButton(
                  minWidth: MediaQuery.of(context).size.width/2.5,
                  color: Color(0xFF009ffd),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: (){
                    MapsLauncher.launchCoordinates(widget.loc[0], widget.loc[1]);
                  },
                  child: Container(
                    height: 50,
                    child: Center(
                      child: Text(
                        "Visit",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
