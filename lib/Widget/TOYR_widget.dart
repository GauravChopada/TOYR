import 'package:flutter/material.dart';
import '../Screens/toyr_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toyr2/Screens/toyr_screen.dart';

class ToyrWidget extends StatelessWidget {
  // const ToyrWidget({ Key? key }) : super(key: key);
  final String name;
  final String imgUrl;

  ToyrWidget({required this.name, required this.imgUrl});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(toyrScreen.Routename),
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
                      "On Date: 23/10/2002",
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
