import 'package:flutter/cupertino.dart';
import 'package:green_house/presentation/screens/auth_screen.dart';
import 'package:green_house/presentation/screens/home_screen.dart';
import 'package:green_house/presentation/screens/info_screen.dart';

Map<String, WidgetBuilder> routes = {
  AuthScreen.routName: (context) => const AuthScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  InfoScreen.routeName: (context) => InfoScreen(args: const {}),
};
