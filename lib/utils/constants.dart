import 'package:flutter/cupertino.dart';

double getWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

Color myYellow = const Color(0xffcaa601);
Color myLightGreen = const Color(0xff6EA035);
Color myDarkGreen = const Color(0xff1F3724);
Color myDarkYellow = const Color.fromRGBO(202, 166, 1, 0.4);
String baseUrl = 'https://sfc.onrender.com';
