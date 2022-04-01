import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toyr2/Screens/Auth_Screen.dart';
import 'package:toyr2/Screens/Log_In_Screen.dart';
import 'Screens/home_page.dart';
import 'Screens/toyr_screen.dart';
import 'Screens/create_Package.dart';
import 'Screens/update_Package.dart';
import 'Screens/view_Profile.dart';
import 'Screens/memory_Screen.dart';
import 'Providers/Auth.dart';
import 'Screens/view_on_map.dart';
import 'Screens/view_All_TOYRS.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Screens/favourites_Screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget currentPage = AuthScreen();
  Auth authClass = Auth();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Firebase.initializeApp().whenComplete(() {
    //   print("completed");
    //   setState(() {});
    // });
    // print("................");
    checkAuth();
  }

  Future<void> checkAuth() async {
    final token = await authClass.getToken();
    print(token);
    if (token != null) {
      setState(() {
        // print("you are here ....");
        currentPage = HomeScreen();
      });
    }
  }

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: Auth()),
        ],
        child: Consumer<Auth>(builder: (ctx, auth, _) {
          // print("1................" + (await Auth().token).toString());
          // Auth().tryAutoLogIn();
          // print("2................" + await Auth().token);

          return MaterialApp(
            // home: AuthScreen(),
            // home: HomeScreen(),
            // home: currentPage,
            // home: MapSample(),
            home: FutureBuilder(
                future: _initialization,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Scaffold(
                      body: Center(
                          child: Text("Error: " + snapshot.error.toString())),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    return StreamBuilder(
                      stream: FirebaseAuth.instance.authStateChanges(),
                      builder: (ctx, userSnapShot) {
                        if (userSnapShot.hasData) {
                          return HomeScreen();
                        }
                        return AuthScreen();
                      },
                    );
                  }

                  return Scaffold(
                    body: Center(child: Text("initializing App....")),
                  );
                }),
            theme: ThemeData(
              primaryColor: Colors.black,
              accentColor: Colors.black,
              textTheme: GoogleFonts.poppinsTextTheme(
                Theme.of(context).textTheme,
              ),
            ),
            debugShowCheckedModeBanner: false,
            routes: {
              toyrScreen.Routename: (ctx) => toyrScreen(),
              LogInScreen.Routename: (ctx) => LogInScreen(),
              AuthScreen.Routename: (ctx) => AuthScreen(),
              createPackageScreen.Routename: (ctx) => createPackageScreen(),
              HomeScreen.Routename: (ctx) => HomeScreen(),
              updatePackageScreen.Routename: (context) => updatePackageScreen(),
              memoryScreen.Routename: (context) => memoryScreen(),
              viewProfile.Routename: (context) => viewProfile(),
              viewAllTOYRSScreen.Routename: (context) => viewAllTOYRSScreen(),
              favouritesScreen.Routename: (context) => favouritesScreen(),
              viewOnMap.Routename: (context) => viewOnMap(),
            },
          );
        }));
  }
}

// class MapSample extends StatefulWidget {
//   @override
//   State<MapSample> createState() => MapSampleState();
// }

// class MapSampleState extends State<MapSample> {
//   Completer<GoogleMapController> _controller = Completer();

//   static final CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );

//   static final CameraPosition _kLake = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(37.43296265331129, -122.08832357078792),
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414);

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       body: GoogleMap(
//         mapType: MapType.hybrid,
//         initialCameraPosition: _kGooglePlex,
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: _goToTheLake,
//         label: Text('To the lake!'),
//         icon: Icon(Icons.directions_boat),
//       ),
//     );
//   }

//   Future<void> _goToTheLake() async {
//     final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//   }
// }
