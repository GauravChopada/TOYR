import 'dart:ui';

import 'package:flutter/material.dart';
import '../Screens/toyr_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toyr2/Screens/toyr_screen.dart';

class PlaceWidget extends StatelessWidget {
  // const ToyrWidget({ Key? key }) : super(key: key);
  final String placeName;
  final String city;
  final String imgUrl;

  PlaceWidget(
      {required this.placeName, required this.city, required this.imgUrl});
  @override
  Widget build(BuildContext context) {
    // return InkWell(
    //   // onTap: () => Navigator.of(context).pushNamed(toyrScreen.Routename),
    //   child: Container(
    //     // height: 300,
    //     margin: EdgeInsets.all(10),
    //     decoration: BoxDecoration(
    //         color: Color(0xFFDADAE4), borderRadius: BorderRadius.circular(20)),
    //     child: Stack(
    //       // crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Container(
    //             height: 293,
    //             width: MediaQuery.of(context).size.width,
    //             child: ClipRRect(
    //               borderRadius: BorderRadius.circular(20),
    //               child: Image.network(
    //                 imgUrl,
    //                 fit: BoxFit.cover,
    //               ),
    //             )),
    //         Expanded(
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Container(
    //                 padding: EdgeInsets.only(left: 20, top: 10),
    //                 child: Text(
    //                   name,
    //                   style: GoogleFonts.roboto(
    //                       fontSize: 24, fontWeight: FontWeight.bold),
    //                 ),
    //               ),
    //               Container(
    //                 padding: EdgeInsets.only(left: 20, bottom: 10, top: 5),
    //                 child: Text(
    //                   "On Date: 23/10/2002",
    //                   style: GoogleFonts.roboto(
    //                       fontSize: 13, fontWeight: FontWeight.bold),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    return Container(
      padding: EdgeInsets.all(10),
      child: Stack(
        children: [
          Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              // width: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  imgUrl,
                  fit: BoxFit.cover,
                ),
              )),
          Positioned(
            top: 150,
            left: 0,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                    // width: MediaQuery.of(context).size.width,
                    // width: 80,
                    margin:
                        EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 19, sigmaY: 19),
                      child: Row(
                        children: [
                          Container(
                            child: Icon(
                              Icons.location_on_outlined,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            "" + placeName + ", " + city,
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
