import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../presentation/widgets/app_popup.dart';
import '../utils/constants.dart';

class UserStore with ChangeNotifier {
  // https://sfc.onrender.com/users/getUser
  String? userName;

  Future<void> getUserData(BuildContext context, String token) async {
    try {
      Response response = await get(
        Uri.parse('$baseUrl/users/getUser'),
        headers: {'Authorization': 'Bearer $token'},
      );
      // print(response.body);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        userName = responseData['firstName'] + ' ' + responseData['lastName'];
        notifyListeners();
      }
    } catch (e) {
      AppPopup.showMyDialog(context, e.toString());
    }
  }
}
