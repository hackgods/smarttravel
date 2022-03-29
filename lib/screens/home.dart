import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarttravel/animations/fadeanimation.dart';
import 'package:smarttravel/widgets/hotels.dart';
import 'package:smarttravel/widgets/sliverbar.dart';
import 'package:smarttravel/widgets/touristplaces.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String test = "";


  @override
  void initState() {
    //print("hello");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: CustomScrollView(
        slivers: [
          const SliverPersistentHeader(
            delegate: SliverSearchAppBar(),
            pinned: true,
          ),
          SliverList(
              delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 24,right: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeAnimation(0.15, Text("Nearby You",textAlign: TextAlign.left,style: GoogleFonts.poppins(fontSize: 26,fontWeight: FontWeight.w500,color: Colors.black),)),
                        TouristPlaceNearby(),
                        FadeAnimation(0.15, Text("Hotels to stay",textAlign: TextAlign.left,style: GoogleFonts.poppins(fontSize: 26,fontWeight: FontWeight.w500,color: Colors.black),)),
                        HotelsScreen(),

                      ],
                  ),
                );
              }, childCount: 1))
        ],
      ),
    );
  }
}
