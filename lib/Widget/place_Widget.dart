import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Screens/toyr_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toyr2/Screens/toyr_screen.dart';

class PlaceWidget extends StatelessWidget {
  // const ToyrWidget({ Key? key }) : super(key: key);
  // final String placeName;
  // final String city;
  // final String imgUrl;
  final String id;

  // PlaceWidget(
  // {required this.placeName, required this.city, required this.imgUrl});
  PlaceWidget({
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final DocumentReference _placeRef =
        FirebaseFirestore.instance.doc('places/' + id);
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
    return FutureBuilder<DocumentSnapshot>(
        future: _placeRef.get(),
        builder: (ctx, snapshot) {
          final document = snapshot.data;
          // final reqDoc = document.where((element) {
          //   print(element.id);
          // });
          // print(reqDoc.elementAt(0).get('packageName'));
          // print("  ===============================");
          // print(document?.get('placeName'));
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text("Loading..."));
          }
          if (snapshot.hasError) {
            return Text("Error...");
          }
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
                        document?.get('imgUrl'),
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
                          margin: EdgeInsets.only(
                              left: 10, right: 10, bottom: 5, top: 5),
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
                                  "" +
                                      document?.get('placeName') +
                                      ", " +
                                      document?.get('city'),
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
        });
  }
}
