import 'package:flutter/material.dart';

import 'Log_In_Screen.dart';

enum AuthType { Login, SignUp }

class AuthScreen extends StatelessWidget {
  static const Routename = './AuthScreen';
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.deepPurple.shade50, Colors.deepPurple],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight)),
        ),
        Positioned(
            top: size.height * 0.15,
            left: size.width * 0.05,
            //
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello !',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.w800),
                ),
                Text(
                  'Welcome to TOYR App.',
                  style: TextStyle(fontSize: 20, color: Colors.black54),
                )
              ],
            )),
        Positioned(
            top: size.height * 0.6,
            left: size.width * 0.1,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, LogInScreen.Routename,
                        arguments: AuthType.Login);
                  },
                  child: Card(
                    color: Colors.deepPurple,
                    elevation: 7,
                    child: Container(
                        alignment: Alignment.center,
                        width: size.width * 0.8,
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'Log in',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, LogInScreen.Routename,
                        arguments: AuthType.SignUp);
                  },
                  child: Card(
                    color: Colors.deepPurple[50],
                    // color: Colors.blue[50],
                    elevation: 7,
                    child: Container(
                        alignment: Alignment.center,
                        width: size.width * 0.8,
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'Register now',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple),
                        )),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                  ),
                ),
              ],
            ))
      ],
    ));
  }
}
