import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'backgroundwave.dart';

class SliverSearchAppBar extends SliverPersistentHeaderDelegate {
  const SliverSearchAppBar();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var adjustedShrinkOffset =
    shrinkOffset > minExtent ? minExtent : shrinkOffset;
    double offset = (minExtent - adjustedShrinkOffset) * 0.5;
    double topPadding = MediaQuery.of(context).padding.top + 16;

    return Stack(
      children: [
        const BackgroundWave(
          height: 280,
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top*1.2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Discover",textAlign: TextAlign.left,style: GoogleFonts.poppins(fontSize: 30,fontWeight: FontWeight.w600,color: Colors.white),),
                Text("Explore best places in Uttarakhand",textAlign: TextAlign.left,style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w300,color: Colors.white.withOpacity(0.9)),),
              ],
            ),
          ),
          left: 16,
          right: 16,
        )
      ],
    );
  }

  @override
  double get maxExtent => 280;

  @override
  double get minExtent => 140;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      oldDelegate.maxExtent != maxExtent || oldDelegate.minExtent != minExtent;
}