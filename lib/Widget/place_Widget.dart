import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Screens/toyr_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toyr2/Screens/toyr_screen.dart';

class PlaceWidget extends StatelessWidget {
  // final String placeName;
  // final String city;
  // final String imgUrl;
  final String id;

  PlaceWidget({
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final DocumentReference _placeRef =
        FirebaseFirestore.instance.doc('places/' + id);

    return FutureBuilder<DocumentSnapshot>(
        future: _placeRef.get(),
        builder: (ctx, snapshot) {
          final document = snapshot.data;

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
