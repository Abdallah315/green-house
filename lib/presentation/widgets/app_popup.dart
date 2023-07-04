import 'package:flutter/material.dart';
import 'package:green_house/utils/constants.dart';

class AppPopup {
  static showMyDialog(BuildContext context, String? message) async {
    print('msg: $message');
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              Text(message ?? 'Something went wrong, Please try again later'),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          actions: <Widget>[
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: myLightGreen,
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.6,
                      MediaQuery.of(context).size.height * 0.06),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                // Navigator.of(ctx, rootNavigator: true).pop(),
                child: const Text(
                  "OK",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            )
          ],
        );
      },
    );
  }
}
