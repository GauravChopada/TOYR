import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Screens/toyr_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toyr2/Screens/toyr_screen.dart';

class ToyrWidget extends StatelessWidget {
  // const ToyrWidget({ Key? key }) : super(key: key);
  final String id;
  final String name;
  final String imgUrl;
  final Timestamp date;

  ToyrWidget(
      {required this.name,
      required this.imgUrl,
      required this.id,
      required this.date});
  @override
  Widget build(BuildContext context) {
    DateTime onDate = date.toDate();
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(toyrScreen.Routename, arguments: {'id': id}),
      child: Container(
        // height: 300,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Color(0xFFDADAE4), borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 293,
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    imgUrl,
                    fit: BoxFit.cover,
                  ),
                )),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20, top: 10),
                    child: Text(
                      name,
                      style: GoogleFonts.roboto(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20, bottom: 10, top: 5),
                    child: Text(
                      "On Date: " +
                          onDate.day.toString() +
                          "/" +
                          onDate.month.toString() +
                          "/" +
                          onDate.year.toString(),
                      style: GoogleFonts.roboto(
                          fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
