import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/http_exception.dart';

class Auth with ChangeNotifier {
  late String? _token;
  DateTime? _expiryDate;
  late String? _userId;

  // late Timer? _authTimer;
  bool get isAuth {
    // notifyListeners();
    print(token != null);
    return token != null;
  }

  Future<String?> get token async {
    // final prefs = await SharedPreferences.getInstance();
    // if (!prefs.containsKey('userData')) {
    //   return "Error";
    // }
    // final extractedData =
    //     json.decode(prefs.getString('userData') ?? "") as Map<String, Object>;
    // _token = extractedData['token'].toString();
    // return _token;

    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
    // return _token;
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return "Error";
    }
    final extractedData =
        json.decode(prefs.getString('userData') ?? "") as Map<String, dynamic>;
    _token = extractedData['token'].toString();
    return _token;

    // if (_expiryDate != null &&
    //     _expiryDate!.isAfter(DateTime.now()) &&
    //     _token != null) {
    //   return _token;
    // }
    // return null;
    // return _token;
  }

  String? get userId {
    return _userId;
  }

  Future<bool> tryAutoLogIn() async {
    final prefs = await SharedPreferences.getInstance();
    // print(prefs.getString('userData'));
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedData =
        json.decode(prefs.getString('userData') ?? "") as Map<String, dynamic>;
    final expiryDate = DateTime.parse(extractedData['expiryDate'].toString());
    // print("......................................." + expiryDate.toString());
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedData['token'].toString();
    _userId = extractedData['userId'].toString();
    _expiryDate = expiryDate;
    notifyListeners();
    // autoLogOut();
    return true;
  }

  Future<void> signUp(
    String email,
    String pswd,
  ) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCnwUO68OPX1n_t-wojA4xxDpjxUnbpXXM');
    try {
      final response = await http.post(url,
          body: json.encode(
              {'email': email, 'password': pswd, 'returnSecureToken': true}));
      final responseData = json.decode(response.body);
      // print(responseData);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      _userId = responseData['localId'];
      // autoLogOut(context);
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate!.toIso8601String()
      });
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> signIn(
    String email,
    String pswd,
  ) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCnwUO68OPX1n_t-wojA4xxDpjxUnbpXXM');
    try {
      final response = await http.post(url,
          body: json.encode(
              {'email': email, 'password': pswd, 'returnSecureToken': true}));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      // print(responseData);
      _token = responseData['idToken'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      print(responseData['expiresIn']);
      print(_expiryDate);
      _userId = responseData['localId'];
      // autoLogOut(context);
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate!.toIso8601String()
      });
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> logOut() async {
    _token = null;
    _expiryDate = DateTime.now();
    _userId = null;
    // if (_authTimer != null) {
    //   _authTimer!.cancel();
    //   _authTimer;
    // }
    final prefs = await SharedPreferences.getInstance();
    // print(prefs.getString('userData'));
    prefs.clear();
    // print(prefs.getString('userData'));
    // final prrefs = await SharedPreferences.getInstance();
    // print(prrefs.getString('userData'));
    // Navigator.of(context).pushReplacementNamed(AuthScreen.Routename)
    notifyListeners();
  }

  // void autoLogOut() {
  //   if (_authTimer != null) {
  //     _authTimer.cancel();
  //   }
  //   final timeToExpire = _expiryDate.difference(DateTime.now()).inSeconds;
  //   _authTimer = Timer(Duration(seconds: timeToExpire), () {
  //     logOut();
  //     // Navigator.of(context).pushReplacementNamed(AuthScreen.Routename);
  //   });
  // }
}
