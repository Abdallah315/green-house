import 'package:flutter/material.dart';
import 'package:green_house/utils/constants.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({
    super.key,
  });
  static const routeName = '/info';

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myDarkGreen,
        title: const Text('About US'),
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
              child: Text(
                'This project serves as an innovative model for achieving agricultural production efficiently and sustainably without the need for traditional soil. It involves the utilization of advanced techniques for cultivating crops and plants in indoor or industrial environments, with less emphasis on conventional farmland.Modern agriculture faces significant challenges such as scarcity of arable land, soil and water pollution, and climate change. Therefore, it is crucial to seek sustainable and innovative solutions to ensure the availability of food and agricultural resources in a smart and efficient manner.This study aims to analyze and explore the latest techniques and systems used in soilless agriculture. We will examine various types of projects that rely on technologies like hydroponics and aeroponics, which involve growing plants without soil using nutrient-rich solutions or misting environments. We will investigate the benefits and challenges associated with these systems and how they can contribute to improving food security and environmental sustainability.The research team consists of students from the College of Agricultural Engineering who are dedicated to achieving tangible and innovative results. We will design experimental models for soilless agriculture and apply advanced techniques such as light regulation, nutrient supply, and environmental monitoring. We will also analyze data, evaluate performance, and assess the effectiveness of these innovative systems.This project is expected to have a significant impact on the future of agriculture and sustainable development. It will contribute to providing smart and sustainable solutions for food production and agricultural resources, improving efficiency, and reducing reliance on traditional farmland and soil. The findings from this project will enhance our understanding of agriculture and its techniques, empowering us to meet the needs of our society in terms of food security and sustainable development.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              )),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Text(
                  'See our products',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                    onTap: () async {
                      const String url = 'http://psc-s.com/';
                      launchUrl(url);
                      // Navigator.of(context, rootNavigator: true).pop();
                    },
                    child: Text(
                      'http://psc-s.com/',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.blueAccent),
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }

  launchUrl(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'can\'t launch url';
    }
  }
}
