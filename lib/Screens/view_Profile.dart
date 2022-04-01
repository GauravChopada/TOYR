import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'memory_Screen.dart';
import '../Models/TOYR.dart';
import '../Widget/TOYR_widget.dart';

class viewProfile extends StatefulWidget {
  static const Routename = './viewProfile';

  @override
  State<viewProfile> createState() => _viewProfileState();
}

class _viewProfileState extends State<viewProfile> {
  String profileImgUrl =
      'https://monomousumi.com/wp-content/uploads/anonymous-user-3.png';

  String userName = '';
  final List<TOYR> yourTOYR = [];
  bool _isFirstTimeLoaded = true;
  List<String> listOfMemories = [
    // 'https://firebasestorage.googleapis.com/v0/b/toyr-c7bd9.appspot.com/o/packages%2F2022-03-25%2014%3A43%3A58.244810%2Fmemories%2F2022-03-25%2014%3A45%3A44.220390.jpg?alt=media&token=52d77117-d2a1-49c2-a303-da674d6cc28f',
    // 'https://firebasestorage.googleapis.com/v0/b/toyr-c7bd9.appspot.com/o/packages%2F2022-03-25%2014%3A43%3A58.244810%2Fmemories%2F2022-03-25%2014%3A45%3A44.220390.jpg?alt=media&token=52d77117-d2a1-49c2-a303-da674d6cc28f',
    // 'https://firebasestorage.googleapis.com/v0/b/toyr-c7bd9.appspot.com/o/packages%2F2022-03-25%2014%3A43%3A58.244810%2Fmemories%2F2022-03-25%2014%3A45%3A44.220390.jpg?alt=media&token=52d77117-d2a1-49c2-a303-da674d6cc28f'
  ];
  @override
  Widget build(BuildContext context) {
    final sf = SharedPreferences.getInstance();
    sf.then(
      (value) {
        setState(() {
          profileImgUrl = value.getString('profileImgUrl')!;
          userName = value.getString('userName')!;
        });
      },
    );
    if (_isFirstTimeLoaded) {
      final ff = FirebaseFirestore.instance.collection('packages').get();
      ff.then(
        (value) {
          setState(() {
            final document = value.docs;
            document.forEach((element) {
              if (element.get('createdBy') ==
                  FirebaseAuth.instance.currentUser!.email) {
                yourTOYR.add(TOYR(
                    toyrId: element.id,
                    name: element.get('packageName'),
                    imgUrl: element.get('imgUrl'),
                    createdAt: element.get('createdAt'),
                    views: element.get('views')));

                final _memories = element.get('memories') as List<dynamic>;
                _memories.forEach((element) {
                  listOfMemories.add(element.toString());
                });
              }
            });
          });
        },
      );
      _isFirstTimeLoaded = false;
    }

    return Scaffold(
      body: Container(
          color: Colors.black,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.13,
                padding: const EdgeInsets.only(left: 15, top: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            color: Colors.white,
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.arrow_back_ios_new)),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('Profile',
                            style: GoogleFonts.lato(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                padding: const EdgeInsets.symmetric(vertical: 8),
                height: MediaQuery.of(context).size.height * 0.85,
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                              width: 80,
                              height: 80.0,
                              margin: const EdgeInsets.only(
                                top: 24.0,
                                bottom: 15.0,
                              ),
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                shape: BoxShape.circle,
                              ),
                              child: Image.network(
                                profileImgUrl,
                                fit: BoxFit.cover,
                              )),
                          Container(
                            padding: EdgeInsets.only(left: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(userName,
                                      style: GoogleFonts.lato(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    'Email: ' +
                                        (FirebaseAuth
                                                .instance.currentUser!.email)
                                            .toString(),
                                    style: GoogleFonts.lato(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black)),
                              ],
                            ),
                          )
                        ],
                      ),
                      const Divider(
                        indent: 10,
                        endIndent: 10,
                        color: Colors.grey,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "YOUR TOYRS",
                          style: GoogleFonts.roboto(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        margin:
                            const EdgeInsets.only(top: 20, left: 5, bottom: 10),
                      ),
                      if (yourTOYR.isEmpty)
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 30),
                          child: Center(
                              child:
                                  Text("You haven't Created Any TOYRS Yet!!")),
                        ),
                      if (yourTOYR.isNotEmpty)
                        Container(
                          height:
                              MediaQuery.of(context).size.height * 0.565 < 395
                                  ? MediaQuery.of(context).size.height * 0.5
                                  : 390,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            itemBuilder: (ctx, i) => Container(
                                width: 330,
                                child: ToyrWidget(
                                  name: yourTOYR[i].name,
                                  imgUrl: yourTOYR[i].imgUrl,
                                  date: yourTOYR[i].createdAt,
                                  id: yourTOYR[i].toyrId,
                                )),
                            itemCount: yourTOYR.length,
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                          ),
                        ),
                      Container(
                        padding: EdgeInsets.only(top: 5, left: 15, bottom: 20),
                        child: Text(
                          "Memories",
                          style: GoogleFonts.poppins(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15))),
                            padding:
                                EdgeInsets.only(top: 5, left: 10, right: 10),
                            width: MediaQuery.of(context).size.width,
                            height: listOfMemories.length <= 2 ? 220 : 400,
                            child: listOfMemories.isEmpty
                                ? const Center(
                                    child: Text(
                                      "No Memories Added Yet!!!",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                : GridView.builder(
                                    physics: BouncingScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 1,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10),
                                    itemCount: listOfMemories.length < 4
                                        ? listOfMemories.length
                                        : 4,
                                    itemBuilder: (ctx, index) {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Container(
                                            child: Image.network(
                                              listOfMemories[index],
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                          ),
                          if (listOfMemories.isNotEmpty)
                            Container(
                              color: Colors.grey[300],
                              width: MediaQuery.of(context).size.width,
                              child: TextButton(
                                  child: Text(
                                    "View all",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        memoryScreen.Routename,
                                        arguments: {
                                          'memories': listOfMemories
                                        });
                                  }),
                            ),
                          Container(
                            height: 30,
                            color: Colors.grey[300],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
