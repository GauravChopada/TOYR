import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class forgotPasswordScreen extends StatefulWidget {
  static const Routename = './forgotPasswordScreen';
  @override
  State<forgotPasswordScreen> createState() => _forgotPasswordScreenState();
}

class _forgotPasswordScreenState extends State<forgotPasswordScreen> {
  // const forgotPasswordScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formkey = GlobalKey();

  Map<String, String> _authData = {'Email': ''};

  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('An Error Occured!'),
              content: Text(msg),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text('Okay'))
              ],
            ));
  }

  var _isLoading = false;
  var _emailSent = false;

  @override
  Widget build(BuildContext context) {
    final islandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final Size size = MediaQuery.of(context).size;

    void _saveForm() async {
      FocusScope.of(context).unfocus();

      if (!_formkey.currentState!.validate()) {
        return;
      }
      setState(() {
        _isLoading = true;
      });
      _formkey.currentState!.save();
      // UserCredential authresult;
      // try {
      //   if (authType == AuthType.Login) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _authData['Email']!.trim(),
        );
        setState(() {
          _emailSent = true;
          _isLoading = false;
        });
      } catch (error) {
        print(error);
        const errormsg = 'Could not find any User with provided Email-id ';
        setState(() {
          _isLoading = false;
        });
        _showErrorDialog(errormsg);
      }
    }

    return Scaffold(
      body: Container(
          child: Stack(
        children: [
          Positioned(
            child: Container(
              height: size.height,
              width: size.width,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'Assets/images/authPhoto.jpg',
                        height: islandscape ? size.height : size.height * 0.28,
                        width: islandscape ? size.width * 0.3 : size.width,
                        fit: BoxFit.cover,
                        alignment: Alignment.bottomCenter,
                      ),
                      if (islandscape) Spacer(),
                    ],
                  ),
                  if (!islandscape) Spacer(),
                ],
              ),
            ),
          ),
          Positioned(
              top: 40,
              left: 15,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        color: Colors.black12,
                        height: 40,
                        width: 40,
                      )))),
          Positioned(
              top: 40,
              left: 19,
              child: Container(
                height: 40,
                width: 40,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              )),
          Positioned(
            top: islandscape ? 0 : size.height * 0.27,
            left: islandscape ? size.width * 0.25 : 0,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              width: islandscape ? size.width * 0.75 : size.width,
              height: islandscape ? size.height : size.height * 0.77,
              child: Form(
                key: _formkey,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: islandscape ? 10 : 30),
                      child: Text(
                        "Reset Password",
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w900),
                      ),
                    ),
                    Container(
                      height:
                          islandscape ? size.height * 0.8 : size.height * 0.6,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            if (!_emailSent)
                              TextFormField(
                                key: Key('Email'),
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.bold),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 2.0),
                                    borderRadius: BorderRadius.circular(100.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.deepPurple, width: 2.0),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value!.isEmpty || !value.contains('@')) {
                                    return 'Enter valid Email-id';
                                  }
                                  return null;
                                },
                                textInputAction: TextInputAction.next,
                                onSaved: (value) {
                                  _authData['Email'] = value!;
                                },
                              ),
                            if (!_emailSent)
                              SizedBox(
                                height: islandscape ? 5 : 13,
                              ),
                            if (!_emailSent)
                              GestureDetector(
                                onTap: () {
                                  _isLoading ? null : _saveForm();
                                },
                                child: Card(
                                  color: Colors.deepPurple,
                                  elevation: 5,
                                  child: Container(
                                      alignment: Alignment.center,
                                      // width: size.width * 0.8,
                                      padding:
                                          EdgeInsets.all(islandscape ? 15 : 18),
                                      child: _isLoading
                                          ? CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                          : Text(
                                              'Send Email',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            )),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100)),
                                ),
                              ),
                            // Spacer(),
                            if (!_emailSent)
                              SizedBox(
                                height: 200,
                              ),
                            if (_emailSent)
                              SizedBox(
                                height: 100,
                              ),
                            if (!_emailSent)
                              Container(
                                child: Text(
                                  'You will receive an email on provided email id for reseting password',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            if (_emailSent)
                              Container(
                                child: Text(
                                  'Email sent successfully. . .\ncheck your mails',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            if (_emailSent)
                              SizedBox(
                                height: 20,
                              ),
                            if (_emailSent)
                              FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Go Back',
                                    style: TextStyle(color: Colors.deepPurple),
                                  )),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
