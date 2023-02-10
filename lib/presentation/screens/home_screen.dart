import 'package:flutter/material.dart';
import 'package:green_house/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../bussiness_logic/auth.dart';

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
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        isloading == true
            ? const Center(child: CircularProgressIndicator())
            : SizedBox(
                width: 120,
                height: 65,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isloading = true;
                    });
                    Provider.of<Auth>(context, listen: false).logout();
                    // setState(() {
                    //   isloading = false;
                    // });
                  },
                  child: const Center(
                    child: Text('logout'),
                  ),
                ),
              ),
      ]),
    ));
  }
}
