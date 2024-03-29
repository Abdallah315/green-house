import 'package:flutter/material.dart';
import 'package:green_house/presentation/screens/bottom_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/widgets/app_popup.dart';

class Auth with ChangeNotifier {
  String? _token;

  bool get isAuth {
    return _token != null;
  }

  Future<void> register(
      {required BuildContext context,
      required String firstName,
      required String lastName,
      required String phoneNumber,
      required String country,
      required String email,
      required String password,
      required String confirmPassword}) async {
    final url = Uri.parse('https://sfc.onrender.com/users/register');

    try {
      print({
        firstName,
        lastName,
        email,
        phoneNumber,
        password,
        confirmPassword,
        country
      });
      final resposne = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            'firstName': firstName,
            'lastName': lastName,
            'email': email,
            'password': password,
            'confirmPassword': confirmPassword,
            'country': country,
            'phone': phoneNumber,
          }));

      final responseData = json.decode(resposne.body);
      print(resposne.statusCode);
      // if (responseData['error'] != null) {
      //   AppPopup.showMyDialog(context, responseData['error']);
      //   return;
      // }

      if (resposne.statusCode == 201) {
        _token = responseData['token'];
        notifyListeners();
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => BottomNavBarScreen(),
        ));

        final prefs = await SharedPreferences.getInstance();
        final userData = json.encode({'token': _token});
        prefs.setString('userData', userData);
        // Navigator.of(context).pop();
      } else {
        print(responseData['error']);
        AppPopup.showMyDialog(
            context, (responseData['error'] as List<dynamic>?)?.first);
      }
    } catch (e) {
      AppPopup.showMyDialog(context, e.toString());
    }
  }

  Future<void> login(
      {required BuildContext context,
      required String email,
      required String password}) async {
    final url = Uri.parse('https://sfc.onrender.com/users/login');

    try {
      final resposne = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            'email': email,
            'password': password,
          }));

      final responseData = json.decode(resposne.body);
      if (resposne.statusCode == 200) {
        _token = responseData['token'];
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => BottomNavBarScreen(),
        ));
        notifyListeners();
        final prefs = await SharedPreferences.getInstance();
        final userData = json.encode({'token': _token});
        prefs.setString('userData', userData);
        // Navigator.of(context).pop();
      } else {
        print(responseData['error']);
      }
    } catch (e) {
      AppPopup.showMyDialog(context, e.toString());
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    // print(!prefs.containsKey('userData') && _token != null);
    if (!prefs.containsKey('userData') && _token != null) {
      return false;
    }
    final extractedData =
        json.decode(prefs.getString('userData') ?? '') as Map<String, dynamic>;
    _token = extractedData['token'];
    notifyListeners();
    return true;
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return "";
    }
    final extractedData =
        json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
    _token = extractedData['token'];
    notifyListeners();
    return _token!;
  }

  Future<void> logout() async {
    try {
      // final responseData = json.decode(response.body);
      _token = null;
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      prefs.clear();
    } catch (e) {
      rethrow;
    }
  }
}
