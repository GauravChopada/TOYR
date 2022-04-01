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

class viewAllTOYRSScreen extends StatefulWidget {
  // const viewAllTOYRSScreen({Key? key}) : super(key: key);
  static const Routename = './viewAllTOYRSScreen';

  @override
  State<viewAllTOYRSScreen> createState() => _viewAllTOYRSScreenState();
}

class _viewAllTOYRSScreenState extends State<viewAllTOYRSScreen> {
  final _advancedDrawerController = AdvancedDrawerController();
  void _handleMenuButtonPressed() {
    _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }

  String profileImgUrl =
      'https://monomousumi.com/wp-content/uploads/anonymous-user-3.png';
  String userName = '';
  bool _isFirstTimeLoaded = true;
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
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final _listOfTOYRS = arguments['listOfTOYR'] as List<TOYR>;
    final _title = arguments['title'] as String;
    // DateTime onDate = _listOfTOYRS[].toDate();
    // print(_listOfTOYRS[0].toyrId);
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
                    child: Text(userName,
                        style: GoogleFonts.comfortaa(
                            fontSize: 36,
                            fontWeight: FontWeight.w500,
                            color: Colors.white)),
                  ),
                  // Container(
                  //   child: Text(FirebaseAuth.instance.currentUser.email),
                  // ),\
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
            body: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              const SizedBox(
                height: 70,
              ),
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
                //title
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 15, bottom: 10),
                child: Text(
                  _title,
                  style: GoogleFonts.comfortaa(
                      fontSize: 36, fontWeight: FontWeight.w500),
                ),
                margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
              ),
              Expanded(
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  // height: MediaQuery.of(context).size.height * 0.73,
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (ctx, i) {
                        return InkWell(
                          onTap: () => Navigator.of(context).pushNamed(
                              toyrScreen.Routename,
                              arguments: {'id': _listOfTOYRS[i].toyrId}),
                          child: Container(
                            height: 375,
                            margin: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                color: Color(0xFFDADAE4),
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    height: 293,
                                    width: MediaQuery.of(context).size.width,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        _listOfTOYRS[i].imgUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding:
                                            EdgeInsets.only(left: 20, top: 10),
                                        child: Text(
                                          _listOfTOYRS[i].name,
                                          style: GoogleFonts.roboto(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 20, bottom: 10, top: 5),
                                        child: Text(
                                          "On Date: " +
                                              _listOfTOYRS[i]
                                                  .createdAt
                                                  .toDate()
                                                  .day
                                                  .toString() +
                                              "/" +
                                              _listOfTOYRS[i]
                                                  .createdAt
                                                  .toDate()
                                                  .month
                                                  .toString() +
                                              "/" +
                                              _listOfTOYRS[i]
                                                  .createdAt
                                                  .toDate()
                                                  .year
                                                  .toString(),
                                          style: GoogleFonts.roboto(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold),
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
                      itemCount: _listOfTOYRS.length),
                ),
              ),
            ]))));
  }
}
