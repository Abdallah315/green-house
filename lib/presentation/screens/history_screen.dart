import 'package:flutter/material.dart';
import 'package:green_house/utils/constants.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({
    super.key,
  });
  static const routeName = '/info';

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool isloading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myDarkGreen,
        title: const Text('Image History'),
      ),
      // backgroundColor: const Color(0xffF8F8F8),
      backgroundColor: const Color.fromARGB(255, 238, 238, 238),
      body: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
              width: getWidth(context),
              height: getHeight(context),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 7.0,
                  mainAxisSpacing: 7.0,
                ),
                children: <Widget>[
                  Image.asset('assets/static/1.jpeg'),
                  Image.asset('assets/static/2.jpeg'),
                  Image.asset('assets/static/3.jpeg'),
                  Image.asset('assets/static/4.jpeg'),
                ],
              ))
        ],
      ),
    );
  }
}
