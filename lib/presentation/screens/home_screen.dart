import 'package:flutter/material.dart';
import 'package:green_house/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: getWidth(context),
      height: getHeight(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [],
      ),
    ));
  }
}
