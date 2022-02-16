import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toyr2/Screens/Auth_Screen.dart';
import 'package:toyr2/Screens/Log_In_Screen.dart';
import 'Screens/home_page.dart';
import 'Screens/toyr_screen.dart';
// import '';
import 'Providers/Auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: Auth()),
        ],
        child: Consumer<Auth>(builder: (ctx, auth, _) {
          // print("................" + Auth().token.toString());
          Auth().tryAutoLogIn();
          // print("................" + Auth().token.toString());

          return MaterialApp(
            // home: FutureBuilder(
            //     future: auth.tryAutoLogIn(),
            //     builder: (ctx, snapshot) =>
            //         snapshot.connectionState == ConnectionState.waiting
            //             ? Center(
            //                 child: Scaffold(
            //                   body: Center(
            //                     child: Text('Loading'),
            //                   ),
            //                 ),
            //               )
            //             : auth.isAuth
            //                 ? HomeScreen()
            //                 : AuthScreen()),
            // home: auth.isAuth
            //     ? HomeScreen()
            //     : FutureBuilder(
            //         future: auth.tryAutoLogIn(),
            //         builder: (ctx, snapshot) =>
            //             snapshot.connectionState == ConnectionState.waiting
            //                 ? Center(
            //                     child: Scaffold(
            //                       body: Center(
            //                         child: Text('Loading'),
            //                       ),
            //                     ),
            //                   )
            //                 : AuthScreen()),
            // home: AuthScreen(),
            // home: HomeScreen(),
            home: currentPage,
            theme: ThemeData(
              textTheme: GoogleFonts.poppinsTextTheme(
                Theme.of(context).textTheme,
              ),
            ),
            debugShowCheckedModeBanner: false,
            routes: {
              toyrScreen.Routename: (ctx) => toyrScreen(),
              LogInScreen.Routename: (ctx) => LogInScreen(),
              AuthScreen.Routename: (ctx) => AuthScreen()
            },
          );
        }));
  }
}
