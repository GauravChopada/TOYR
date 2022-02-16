import 'package:flutter/material.dart';
import '../Models/http_exception.dart';
// import 'package:myapp04/Screens/(Home)Product_Overview_Screen.dart';
import 'package:provider/provider.dart';
import '../Providers/Auth.dart';
import 'Auth_Screen.dart';

class LogInScreen extends StatefulWidget {
  static const Routename = './LoginScreen';

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  final GlobalKey<FormState> _formkey = GlobalKey();
  var _isLoading = false;
  bool _showPswd = false;
  Map<String, String> _authData = {'Email': '', 'Password': ''};
  final pswdcontroller = TextEditingController();
  void _showErrorDialod(String msg) {
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

  Widget build(BuildContext context) {
    final islandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    AuthType authType = ModalRoute.of(context)!.settings.arguments as AuthType;
    void _toogleAuthType() {
      setState(() {
        if (authType == AuthType.Login) {
          Navigator.of(context).popAndPushNamed(LogInScreen.Routename,
              arguments: AuthType.SignUp);
        } else {
          Navigator.of(context).popAndPushNamed(LogInScreen.Routename,
              arguments: AuthType.Login);
        }
        // print(authType);
        // print(authType);
      });
    }

    Future<void> _saveForm() async {
      if (!_formkey.currentState!.validate()) {
        return;
      }
      _formkey.currentState!.save();
      {
        setState(() {
          _isLoading = true;
        });
        try {
          if (authType == AuthType.Login) {
            await Provider.of<Auth>(context, listen: false)
                .signIn(_authData['Email'] ?? "", _authData['Password'] ?? "");
          } else {
            await Provider.of<Auth>(context, listen: false)
                .signUp(_authData['Email'] ?? "", _authData['Password'] ?? "");
          }
          Navigator.of(context).pushReplacementNamed('/');
          // Navigator.of(context)
          //     .pushReTOYRmentNamed(ProductOverviewScreen.Routname);
        } on HttpException catch (error) {
          var errormsg = 'Authentication Failed!';
          if (error.msg.contains('EMAIL_EXIST')) {
            errormsg = 'Email is already in use.';
          } else if (error.msg.contains('INVALID_PASSWORD')) {
            errormsg = 'Entered password is wrong.';
          } else if (error.msg.contains('WEAK_PASSWORD')) {
            errormsg = 'Entered password is very weak.';
          } else if (error.msg.contains('INVALID_EMAIL')) {
            errormsg = 'Entered email is invalid';
          } else if (error.msg.contains('EMAIL_NOT_FOUND')) {
            errormsg = 'Could not find any user with that email-id.';
          }
          _showErrorDialod(errormsg);
        } catch (error) {
          const errormsg = 'Could not Authenticate you. Please try again later';
          _showErrorDialod(errormsg);
        }
        setState(() {
          _isLoading = false;
        });
      }
    }

    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Container(
              height: size.height,
              width: size.width,
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.network(
                        'https://image.freepik.com/free-psd/online-shopping-with-laptop-mockup-template-shopping-elements_1150-38886.jpg',
                        height: islandscape ? size.height : size.height * 0.28,
                        width: islandscape ? size.width * 0.3 : size.width,
                        fit: BoxFit.cover,
                        alignment: Alignment.bottomRight,
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
            top: islandscape ? 0 : size.height * 0.23,
            left: islandscape ? size.width * 0.25 : 0,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              width: islandscape ? size.width * 0.75 : size.width,
              height: islandscape ? size.height : size.height * 0.77,
              child: Form(
                key: _formkey,
                // child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: islandscape ? 10 : 30),
                      child: Row(
                        children: [
                          IconButton(
                              icon: Icon(Icons.arrow_back_ios_rounded),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                          Spacer(
                            flex: islandscape ? 2 : 1,
                          ),
                          Text(
                            authType == AuthType.Login ? 'Log in' : 'Sign Up',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w900),
                          ),
                          Spacer(
                            flex: islandscape ? 3 : 2,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height:
                          islandscape ? size.height * 0.8 : size.height * 0.6,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFormField(
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
                                _authData['Email'] = value ?? "";
                              },
                            ),
                            SizedBox(
                              height: islandscape ? 10 : 18,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              controller: pswdcontroller,
                              validator: (value) {
                                if (value!.length < 8) {
                                  return 'password should be atleast 8 characters long';
                                } else if (value.isEmpty) {
                                  return 'Enter valid password';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _authData['Password'] = value ?? "";
                              },
                              obscureText: _showPswd ? false : true,
                              textInputAction: authType == AuthType.SignUp
                                  ? TextInputAction.next
                                  : TextInputAction.done,
                              decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  child: Icon(_showPswd
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onLongPress: () {
                                    setState(() {
                                      _showPswd = true;
                                    });
                                  },
                                  onLongPressUp: () {
                                    setState(() {
                                      _showPswd = false;
                                    });
                                  },
                                  onTap: () {
                                    setState(() {
                                      _showPswd = !_showPswd;
                                    });
                                  },
                                ),
                                hintText: 'Password',
                                hintStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 2.0),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.deepPurple, width: 2.0),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            ),
                            if (authType == AuthType.SignUp)
                              SizedBox(
                                height: islandscape ? 10 : 18,
                              ),
                            if (authType == AuthType.SignUp)
                              TextFormField(
                                validator: authType == AuthType.SignUp
                                    ? (value) {
                                        if (value!.length < 8) {
                                          return 'password should be atleast 8 characters long';
                                        } else if (value.isEmpty) {
                                          return 'Enter valid password';
                                        } else if (value !=
                                            pswdcontroller.text) {
                                          return 'Passwords do not match';
                                        }
                                        return null;
                                      }
                                    : null,
                                obscureText: true,
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                  hintText: 'Confirm Password',
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.bold),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 2.0),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.deepPurple, width: 2.0),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                              ),
                            SizedBox(
                              height: islandscape ? 5 : 13,
                            ),
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
                                        ? CircularProgressIndicator()
                                        : Text(
                                            authType == AuthType.SignUp
                                                ? 'Register Now'
                                                : 'Log in',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)),
                              ),
                            ),
                            if (authType == AuthType.Login)
                              FlatButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Forgot password?',
                                    style: TextStyle(color: Colors.deepPurple),
                                  )),
                            SizedBox(
                              height: islandscape ? 0 : 50,
                            ),
                            Container(
                                width: size.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      authType == AuthType.Login
                                          ? 'Don\'t have an account ? '
                                          : 'Already have an account?',
                                      style: TextStyle(color: Colors.black45),
                                    ),
                                    FlatButton(
                                        onPressed: _toogleAuthType,
                                        child: Text(
                                          authType == AuthType.Login
                                              ? 'Sign Up'
                                              : 'Log in',
                                          style: TextStyle(
                                              color: Colors.deepPurple),
                                        ))
                                  ],
                                )),
                            SizedBox(
                              height: 100,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          // ),
          // Positioned(
          //     top: size.height * 0.9,
          //     child:
          // Positioned(
          //   top: size.height * 0.265,
          //   left: 10,
          //   child: IconButton(
          //       icon: Icon(Icons.arrow_back_ios_rounded),
          //       onPressed: () {
          //         Navigator.of(context).pop();
          //       }),
          // )
        ],
      ),
    );
  }
}
