import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:toyr2/Providers/Auth.dart';
import 'package:toyr2/Screens/Auth_Screen.dart';
import '../Models/TOYR.dart';
import '../Widget/TOYR_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<TOYR> upcomingTOYR = [
    TOYR(
        toyrId: "p1",
        name: "Surat Trip",
        imgUrl:
            "https://c0.wallpaperflare.com/preview/403/5/230/bridge-water-building-waterfront.jpg"),
    TOYR(
        toyrId: "p2",
        name: "Mumbai",
        imgUrl:
            "https://images.unsplash.com/photo-1529253355930-ddbe423a2ac7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bXVtYmFpfGVufDB8fDB8fA%3D%3D&w=1000&q=80"),
    TOYR(
        toyrId: "p3",
        name: "Surat",
        imgUrl:
            "https://w0.peakpx.com/wallpaper/445/806/HD-wallpaper-surat-city-ab.jpg"),
    TOYR(
        toyrId: "p4",
        name: "Surat",
        imgUrl:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/International_Business_Center%2C_Piplod%2C_Surat..jpg/250px-International_Business_Center%2C_Piplod%2C_Surat..jpg"),
    TOYR(
        toyrId: "p5",
        name: "Surat",
        imgUrl:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/International_Business_Center%2C_Piplod%2C_Surat..jpg/250px-International_Business_Center%2C_Piplod%2C_Surat..jpg")
  ];

  final List<TOYR> pastTOYR = [
    TOYR(
        toyrId: "p1",
        name: "Surat",
        imgUrl:
            "https://c0.wallpaperflare.com/preview/403/5/230/bridge-water-building-waterfront.jpg"),
    TOYR(
        toyrId: "p2",
        name: "Mumbai",
        imgUrl:
            "https://images.unsplash.com/photo-1529253355930-ddbe423a2ac7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bXVtYmFpfGVufDB8fDB8fA%3D%3D&w=1000&q=80"),
    TOYR(
        toyrId: "p3",
        name: "Surat",
        imgUrl:
            "https://w0.peakpx.com/wallpaper/445/806/HD-wallpaper-surat-city-ab.jpg"),
    TOYR(
        toyrId: "p4",
        name: "Surat",
        imgUrl:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/International_Business_Center%2C_Piplod%2C_Surat..jpg/250px-International_Business_Center%2C_Piplod%2C_Surat..jpg"),
    TOYR(
        toyrId: "p5",
        name: "Surat",
        imgUrl:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/International_Business_Center%2C_Piplod%2C_Surat..jpg/250px-International_Business_Center%2C_Piplod%2C_Surat..jpg")
  ];

  final List<TOYR> sharedTOYR = [
    TOYR(
        toyrId: "p1",
        name: "Surat",
        imgUrl:
            "https://c0.wallpaperflare.com/preview/403/5/230/bridge-water-building-waterfront.jpg"),
    TOYR(
        toyrId: "p2",
        name: "Mumbai",
        imgUrl:
            "https://images.unsplash.com/photo-1529253355930-ddbe423a2ac7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bXVtYmFpfGVufDB8fDB8fA%3D%3D&w=1000&q=80"),
    TOYR(
        toyrId: "p3",
        name: "Surat",
        imgUrl:
            "https://w0.peakpx.com/wallpaper/445/806/HD-wallpaper-surat-city-ab.jpg"),
    TOYR(
        toyrId: "p4",
        name: "Surat",
        imgUrl:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/International_Business_Center%2C_Piplod%2C_Surat..jpg/250px-International_Business_Center%2C_Piplod%2C_Surat..jpg"),
    TOYR(
        toyrId: "p5",
        name: "Surat",
        imgUrl:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/International_Business_Center%2C_Piplod%2C_Surat..jpg/250px-International_Business_Center%2C_Piplod%2C_Surat..jpg")
  ];

  final _advancedDrawerController = AdvancedDrawerController();
  final Future<FirebaseApp> _initilization = Firebase.initializeApp();
  void _handleMenuButtonPressed() {
    _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initilization,
      builder: (ctx, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        if (snapshot.connectionState == ConnectionState.done) {
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
                      // Container(
                      //   width: 128.0,
                      //   height: 128.0,
                      //   margin: const EdgeInsets.only(
                      //     top: 24.0,
                      //     bottom: 64.0,
                      //   ),
                      //   clipBehavior: Clip.antiAlias,
                      //   decoration: BoxDecoration(
                      //     color: Colors.black26,
                      //     shape: BoxShape.circle,
                      //   ),
                      //   child: Image.asset(
                      //     'assets/images/flutter_logo.png',
                      //   ),
                      // ),
                      ListTile(
                        onTap: () {},
                        leading: Icon(Icons.home),
                        title: Text('Home'),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: Icon(Icons.account_circle_rounded),
                        title: Text('Profile'),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: Icon(Icons.favorite),
                        title: Text('Favourites'),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: Icon(Icons.settings),
                        title: Text('Settings'),
                      ),
                      ListTile(
                        onTap: () {
                          Auth().logOut();
                          Navigator.of(context).pushNamed(AuthScreen.Routename);
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
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      // .collection("chat/sVGNkzJGDlxJh8RFR10G")
                      .collection("chat")
                      .snapshots()
                      .listen((event) {
                    print(event.docs[0].get("Name"));
                  });
                },
              ),
              body: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 15, right: 5),
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
                              borderRadius: BorderRadius.circular(15)),
                          child: IconButton(
                            onPressed: _handleMenuButtonPressed,
                            icon: ValueListenableBuilder<AdvancedDrawerValue>(
                              valueListenable: _advancedDrawerController,
                              builder: (_, value, __) {
                                return AnimatedSwitcher(
                                  duration: Duration(milliseconds: 250),
                                  child: Icon(
                                    value.visible ? Icons.clear : Icons.menu,
                                    key: ValueKey<bool>(value.visible),
                                  ),
                                );
                              },
                            ),
                          )),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "TOYR",
                          style: GoogleFonts.comfortaa(
                              fontSize: 36, fontWeight: FontWeight.w500),
                        ),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                      ),
                    ],
                  ),
                  Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                      // padding: EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height * 0.21,
                      // decoration: BoxDecoration(color: Colors.grey[200]),
                      child: GridView(
                          physics: BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 2.5,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          children: [
                            Container(
                              alignment: Alignment.center,
                              // height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.grey[200]),
                              child: ListTile(
                                leading: Icon(Icons.add),
                                title: Text("Create Package"),
                              ),
                            ),
                            Container(
                              // height: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.grey[200]),
                              child: ListTile(
                                leading: Icon(Icons.add),
                                title: Text("Create Package"),
                              ),
                            ),
                            Container(
                              // height: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.grey[200]),
                              child: ListTile(
                                leading: Icon(Icons.add),
                                title: Text("Create Package"),
                              ),
                            ),
                            Container(
                              // height: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.grey[200]),
                              child: ListTile(
                                leading: Icon(Icons.add),
                                title: Text("Create Package"),
                              ),
                            )
                          ])),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "UPCOMING TOYRS",
                      style: GoogleFonts.roboto(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    margin: const EdgeInsets.only(top: 20, left: 5, bottom: 10),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.565 < 395
                        ? MediaQuery.of(context).size.height * 0.5
                        : 390,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      itemBuilder: (ctx, i) => Container(
                        width: 330,
                        child: ToyrWidget(
                            name: upcomingTOYR[i].name,
                            imgUrl: upcomingTOYR[i].imgUrl),
                      ),
                      itemCount: upcomingTOYR.length,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "PAST TOYRS",
                      style: GoogleFonts.roboto(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    margin: EdgeInsets.only(top: 15, left: 5, bottom: 10),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.565 < 395
                        ? MediaQuery.of(context).size.height * 0.5
                        : 390,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      itemBuilder: (ctx, i) => Container(
                        width: 330,
                        child: ToyrWidget(
                            name: pastTOYR[i].name, imgUrl: pastTOYR[i].imgUrl),
                      ),
                      itemCount: pastTOYR.length,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "SHARED TOYRS",
                      style: GoogleFonts.roboto(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    margin: EdgeInsets.only(top: 15, left: 5, bottom: 10),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.565 < 395
                        ? MediaQuery.of(context).size.height * 0.5
                        : 390,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      itemBuilder: (ctx, i) => Container(
                        width: 330,
                        child: ToyrWidget(
                            name: sharedTOYR[i].name,
                            imgUrl: sharedTOYR[i].imgUrl),
                      ),
                      itemCount: upcomingTOYR.length,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          );
        }
        return Scaffold(
          body: Center(
            child: Text("Initializing..."),
          ),
        );
      },
    );
  }
}
