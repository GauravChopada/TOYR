import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toyr2/Models/TOYR.dart';
import 'dart:ui';
import '../Models/image.dart';
import 'toyr_screen.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import '../Widget/TOYR_widget.dart';
import 'view_Profile.dart';

class favouritesScreen extends StatefulWidget {
  // const viewAllTOYRSScreen({Key? key}) : super(key: key);
  static const Routename = './favouritesScreen';

  @override
  State<favouritesScreen> createState() => _favouritesScreenState();
}

class _favouritesScreenState extends State<favouritesScreen> {
  final _advancedDrawerController = AdvancedDrawerController();
  void _handleMenuButtonPressed() {
    _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }

  String profileImgUrl =
      'https://monomousumi.com/wp-content/uploads/anonymous-user-3.png';
  String userName = '';
  bool _isFirstTimeLoaded = true;
  bool _isFirstTimeLoaded2 = true;

  List<TOYR> listOfFavouriteTOYRS = new List<TOYR>.empty(growable: true);
  @override
  Widget build(BuildContext context) {
    if (_isFirstTimeLoaded) {
      final sf = SharedPreferences.getInstance();
      sf.then(
        (value) {
          setState(() {
            profileImgUrl = value.getString('profileImgUrl')!;
            userName = value.getString('userName')!;
          });
        },
      );
      _isFirstTimeLoaded = false;
    }

    final _title = 'Favourites';

    return AdvancedDrawer(
        backdropColor: Colors.grey.shade900,
        controller: _advancedDrawerController,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        rtlOpening: false,
        disabledGestures: false,
        childDecoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade900,
              blurRadius: 20.0,
              spreadRadius: 5.0,
              offset: Offset(-20.0, 0.0),
            ),
          ],
          borderRadius: BorderRadius.circular(30),
        ),
        drawer: SafeArea(
          child: Container(
            child: ListTileTheme(
              textColor: Colors.white,
              iconColor: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 128.0,
                    height: 128.0,
                    margin: const EdgeInsets.only(
                      top: 24.0,
                      bottom: 30.0,
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(profileImgUrl, fit: BoxFit.cover),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(userName,
                        style: GoogleFonts.comfortaa(
                            fontSize: 36,
                            fontWeight: FontWeight.w500,
                            color: Colors.white)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    indent: 20,
                    color: Colors.grey,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed('/');
                    },
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed(viewProfile.Routename);
                    },
                    leading: Icon(Icons.account_circle_rounded),
                    title: Text('Profile'),
                  ),
                  ListTile(
                    onTap: () {
                      _advancedDrawerController.hideDrawer();
                    },
                    leading: Icon(Icons.arrow_forward),
                    title: Text('Go Back'),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                  ),
                  ListTile(
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      var sf = SharedPreferences.getInstance();
                      sf.then((value) {
                        value.clear();
                        value.commit();
                      });

                      Navigator.of(context).pushNamed('/');
                    },
                    leading: Icon(Icons.logout_rounded),
                    title: Text('LogOut'),
                  ),
                  Spacer(),
                  DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white54,
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 16.0,
                      ),
                      child: Text('Terms of Service | Privacy Policy'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        child: Scaffold(
            body: FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Error 404"),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data == null) {
                      return const Center(
                        child: Text("just a Sec...."),
                      );
                    }
                    final listOfFav =
                        snapshot.data!.get('listOfFavourites') as List<dynamic>;
                    print(listOfFav);
                    return FutureBuilder<QuerySnapshot>(
                        future: FirebaseFirestore.instance
                            .collection("packages")
                            .orderBy('createdAt', descending: true)
                            .get(),
                        builder: (context, snapshot2) {
                          if (snapshot2.hasError) {
                            return Center(
                              child: Text("Error 404"),
                            );
                          }
                          if (snapshot2.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot2.connectionState ==
                              ConnectionState.done) {
                            if (snapshot2.data == null) {
                              return Center(
                                child: Text("just a Sec...."),
                              );
                            }
                            if (_isFirstTimeLoaded2) {
                              final document = snapshot2.data!.docs;
                              document.forEach(
                                (element) {
                                  if (listOfFav.contains(element.id)) {
                                    listOfFavouriteTOYRS.add(new TOYR(
                                        toyrId: element.id,
                                        name: element.get('packageName'),
                                        imgUrl: element.get('imgUrl'),
                                        createdAt: element.get('createdAt'),
                                        views: element.get('views')));
                                  }
                                },
                              );
                              _isFirstTimeLoaded2 = false;
                            }
                            return Container(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  const SizedBox(
                                    height: 70,
                                  ),
                                  Container(
                                      margin:
                                          EdgeInsets.only(left: 15, right: 5),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade400,
                                              blurRadius: 7.0,
                                              spreadRadius: 1.0,
                                              offset: Offset(1.0, 1.0),
                                            ),
                                          ],
                                          color: Colors.grey[200],
                                          // color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: IconButton(
                                        onPressed: _handleMenuButtonPressed,
                                        icon: ValueListenableBuilder<
                                            AdvancedDrawerValue>(
                                          valueListenable:
                                              _advancedDrawerController,
                                          builder: (_, value, __) {
                                            return AnimatedSwitcher(
                                              duration:
                                                  Duration(milliseconds: 250),
                                              child: Icon(
                                                value.visible
                                                    ? Icons.clear
                                                    : Icons.menu,
                                                key: ValueKey<bool>(
                                                    value.visible),
                                              ),
                                            );
                                          },
                                        ),
                                      )),
                                  Container(
                                    //title
                                    padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 15,
                                        bottom: 10),
                                    child: Text(
                                      _title,
                                      style: GoogleFonts.comfortaa(
                                          fontSize: 36,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    margin: const EdgeInsets.only(
                                        top: 10, left: 5, right: 5),
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      width: MediaQuery.of(context).size.width,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      // height: MediaQuery.of(context).size.height * 0.73,
                                      child: ListView.builder(
                                          physics: BouncingScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (ctx, i) {
                                            return InkWell(
                                              onTap: () => Navigator.of(context)
                                                  .pushNamed(
                                                      toyrScreen.Routename,
                                                      arguments: {
                                                    'id':
                                                        listOfFavouriteTOYRS[i]
                                                            .toyrId
                                                  }),
                                              child: Container(
                                                height: 375,
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 10),
                                                decoration: BoxDecoration(
                                                    color: Color(0xFFDADAE4),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                        height: 293,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          child: Image.network(
                                                            listOfFavouriteTOYRS[
                                                                    i]
                                                                .imgUrl,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        )),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 20,
                                                                    top: 10),
                                                            child: Text(
                                                              listOfFavouriteTOYRS[
                                                                      i]
                                                                  .name,
                                                              style: GoogleFonts.roboto(
                                                                  fontSize: 24,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 20,
                                                                    bottom: 10,
                                                                    top: 5),
                                                            child: Text(
                                                              "On Date: " +
                                                                  listOfFavouriteTOYRS[
                                                                          i]
                                                                      .createdAt
                                                                      .toDate()
                                                                      .day
                                                                      .toString() +
                                                                  "/" +
                                                                  listOfFavouriteTOYRS[
                                                                          i]
                                                                      .createdAt
                                                                      .toDate()
                                                                      .month
                                                                      .toString() +
                                                                  "/" +
                                                                  listOfFavouriteTOYRS[
                                                                          i]
                                                                      .createdAt
                                                                      .toDate()
                                                                      .year
                                                                      .toString(),
                                                              style: GoogleFonts.roboto(
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          itemCount:
                                              listOfFavouriteTOYRS.length),
                                    ),
                                  ),
                                ]));
                          }
                          return Center(
                            child: Text('Error at end'),
                          );
                        });
                  }
                  return Center(
                    child: Text('Error at end'),
                  );
                })));
  }
}
