import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_house/utils/constants.dart';

import 'auth_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myGreen,
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          child: Image.asset(
            'assets/images/background 1.png',
          ),
        ),
        SizedBox(
          height: 25,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Positioned(
                  top: -50, child: SvgPicture.asset('assets/icons/logo 1.svg'))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Manage Your \nGreen House',
            style: TextStyle(fontSize: 35, color: myYellow),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'The Green house system is designed \nto Helps us control greenhouses \nfrom afar.',
            style: TextStyle(
                fontSize: 20, color: Color.fromRGBO(202, 166, 1, 0.4)),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: myYellow,
                  fixedSize: Size(getWidth(context) * 0.7, 54),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25))),
              onPressed: () {
                Navigator.of(context).pushNamed(AuthScreen.routName);
              },
              child: const Center(
                child: Text(
                  'Get Started',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              )),
        )
      ]),
    );
  }
}
