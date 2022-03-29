import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:smarttravel/animations/fadeanimation.dart';


class Details extends StatefulWidget {
  final String name;
  final String img;
  final String desc;
  final List loc;
  const Details({this.name,this.img,this.desc,this.loc});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final double expandedHeight = 400;
  final double roundedContainerHeight = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
        SliverPersistentHeader(
        delegate: DetailSliverDelegate(
            expandedHeight: expandedHeight,
            roundedContainerHeight: roundedContainerHeight,
        name: widget.name,
        desc: widget.desc,
        img: widget.img)),

                SliverToBoxAdapter(
                  child: _buildDetail(),
                )
              ],
            )
          ],
        ),
      bottomNavigationBar: SafeArea (
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: FadeAnimation(
            0.35, FlatButton(
                minWidth: MediaQuery.of(context).size.width/1.2,
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
        ),
      ),
    );
  }


  Widget _buildDetail() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          _buildUserInfo(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: FadeAnimation(
              0.3, Text(widget.desc,
                style: GoogleFonts.poppins(color: Colors.black.withOpacity(0.7), fontSize: 18, height: 1.5),
              ),
            ),
          ),

          SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeAnimation(
            0.25, Text(
              widget.name,
              style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final double roundedContainerHeight;
  final String name;
  final String img;
  final String desc;
  final List loc;

  DetailSliverDelegate({this.expandedHeight,this.roundedContainerHeight,this.name,this.img,this.desc,this.loc});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      children: [
        Hero(
          tag: name,
          child: Image.network(img,
                width: MediaQuery.of(context).size.width,
                height: expandedHeight,
                fit: BoxFit.cover),
        ),
        Positioned(
          top: expandedHeight - roundedContainerHeight - shrinkOffset,
          left: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: roundedContainerHeight,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}


