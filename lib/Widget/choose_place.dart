import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Models/place.dart';
import 'package:google_fonts/google_fonts.dart';

class choosePlaces extends StatefulWidget {
  // const choosePlaces({Key? key}) : super(key: key);
  List<String>? listOfPlaces;
  String? city;
  choosePlaces({this.listOfPlaces, this.city});
  @override
  State<choosePlaces> createState() => _choosePlacesState(listOfPlaces, city);
}

class _choosePlacesState extends State<choosePlaces> {
  List<String>? listOfPlaces;
  String? city;
  _choosePlacesState(this.listOfPlaces, this.city);
  final List<place> places = [
    place(
        id: "p1",
        name: "Iskcon Temple",
        imgUrl:
            "https://lh5.googleusercontent.com/p/AF1QipMz9P5BrDQATamw27O9h08B9yt0l71m3v4IWzwj=w1080-k-no"),
    place(
        id: "p2",
        name: "Gopi talav",
        imgUrl:
            "http://touristinformationcenter.net/wp-content/uploads/2021/09/gopi-4.jpg"),
    place(
        id: "p3",
        name: "Dumas",
        imgUrl:
            "https://i.pinimg.com/736x/fe/8c/4b/fe8c4b4f17d110af461affb6f880f00a.jpg"),
    place(
        id: "p4",
        name: "Woop",
        imgUrl:
            "https://pcbodiwala.com/storage/work_experience/5fc5dc150256a1606802453.jpeg"),
    place(
        id: "p5",
        name: "Amazia Water Park",
        imgUrl:
            "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0d/eb/f6/9b/wave-pool.jpg?w=1200&h=1200&s=1")
  ];
  @override
  Widget build(BuildContext context) {
    print(listOfPlaces);
    return Container(
      child: Stack(
        children: [
          Column(children: [
            SizedBox(
              height: 15,
            ),
            Center(
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(100)),
                  child: SizedBox(
                    height: 5,
                    width: 50,
                  )),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, top: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                "" + city.toString() + "'s Places",
                style:
                    GoogleFonts.lato(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 380,
              child: GridView.builder(
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  // itemCount: places.length,
                  itemCount: listOfPlaces!.length,
                  itemBuilder: (ctx, index) {
                    // return Container(
                    //   width: 50,
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(15),
                    //     child: Container(
                    //       child: Image.network(
                    //         places[index].imgUrl,
                    //         fit: BoxFit.fill,
                    //       ),
                    //     ),
                    //   ),
                    // );
                    return FutureBuilder<DocumentSnapshot>(
                        future: FirebaseFirestore.instance
                            .doc('places/' + listOfPlaces![index])
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("just a Sec...."),
                            );
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.data == null) {
                            return Center(
                              child: Text("just a Sec...."),
                            );
                          }
                          final document = snapshot.data;
                          return Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.deepPurple, width: 7),
                                borderRadius: BorderRadius.circular(30)),
                            // padding: EdgeInsets.all(10),
                            child: Stack(
                              children: [
                                Container(
                                    height: 200,
                                    width: MediaQuery.of(context).size.width,
                                    // width: 200,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        document!.get('imgUrl'),
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                                Positioned(
                                  // top: 150,
                                  // left: 0,
                                  bottom: 0,
                                  child: Container(
                                    padding:
                                        EdgeInsets.only(left: 10, bottom: 10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(8),
                                          bottomRight: Radius.circular(8),
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8)),
                                      child: Container(
                                          // width: MediaQuery.of(context).size.width,
                                          // width: 80,
                                          margin: EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              bottom: 5,
                                              top: 5),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 19, sigmaY: 19),
                                            child: Row(
                                              children: [
                                                // Container(
                                                //   child: Icon(
                                                //     Icons.location_on_outlined,
                                                //     color: Colors.white,
                                                //   ),
                                                // ),
                                                // SizedBox(
                                                //   width: 3,
                                                // ),
                                                Text(
                                                  document.get('placeName'),
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: 10,
                                    right: 10,
                                    child: CircleAvatar(
                                      radius: 13,
                                      child: Text(
                                        "" + (index + 1).toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: Colors.deepPurple,
                                    )
                                    // child: CircleAvatar(
                                    //   radius: 13,
                                    //   backgroundColor:
                                    //       Color.fromRGBO(128, 128, 128, 0.7),
                                    // )
                                    )
                              ],
                            ),
                          );
                        });
                  }),
            ),
          ]),
          Positioned(
              bottom: 20,
              left: MediaQuery.of(context).size.width * 0.5 - 45,
              child: FlatButton(
                color: Colors.deepPurple,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  // side: BorderSide(
                  //     color: Colors.deepPurple,
                  //     width: 1,
                  //     style: BorderStyle.solid),
                ),
                child: Text("Done"),
                onPressed: () {},
              ))
        ],
      ),
    );
  }
}
