import 'dart:async';

import 'package:flutter/material.dart';
import 'package:green_house/store/auth.dart';
import 'package:green_house/store/farms.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';

class SensorReadingsScreen extends StatefulWidget {
  final Map<String, dynamic> args;
  const SensorReadingsScreen({super.key, required this.args});

  @override
  State<SensorReadingsScreen> createState() => _SensorReadingsScreenState();
}

class _SensorReadingsScreenState extends State<SensorReadingsScreen> {
  bool isloading = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    fetchReadings();
  }

  fetchReadings() async {
    isloading = true;
    final token = await Provider.of<Auth>(context, listen: false).getToken();
    if (!mounted) return;
    Provider.of<FarmStore>(context, listen: false)
        .getSensorsReadings(context, token, widget.args['serialNumber'])
        .whenComplete(() {
      setState(() {
        isloading = false;
      });
      updateReadings();
    });
  }

  updateReadings() async {
    final token = await Provider.of<Auth>(context, listen: false).getToken();
    _timer = Timer.periodic(const Duration(seconds: 3, milliseconds: 500), (_) {
      Provider.of<FarmStore>(context, listen: false)
          .getSensorsReadings(context, token, widget.args['serialNumber']);
      print('updated');
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xffF8F8F8),
      backgroundColor: const Color.fromARGB(255, 238, 238, 238),
      body: Container(
        width: getWidth(context),
        height: getHeight(context),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: isloading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                // physics: const NeverScrollableScrollPhysics(),
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: myDarkGreen,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getHeight(context) * .02,
                  ),
                  buildFarmData(context),
                  SizedBox(
                    height: getHeight(context) * .04,
                  ),
                  buildSensorReadings(),
                  SizedBox(
                    height: getHeight(context) * .04,
                  ),
                  const Text(
                    'Information :',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'the condition of the plants has started to improve compared to yesterday , now they are starting to bear fruit',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
      ),
    );
  }

  buildFarmData(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          width: getWidth(context) * .9,
          height: getHeight(context) * .15,
          decoration: BoxDecoration(
            color: myDarkGreen,
            borderRadius: BorderRadius.circular(25),
          ),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Tomato',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'The green house',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Farm Status',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Updated Farm Readings',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 11),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
            top: -30, child: Image.asset('assets/images/curved_tomato.png'))
      ],
    );
  }

  buildSensorReadings() {
    return Consumer<FarmStore>(
      builder: (context, farmStore, child) {
        var readings = farmStore.sensorsReadings;
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/hot.png',
                      width: 50,
                      height: 50,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text(
                          'Farm temp',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey),
                        ),
                        Text(
                          readings?.eTemp.toDouble().toStringAsFixed(2) ?? '0',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        )
                      ],
                    )
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/water-temperature.png',
                      width: 50,
                      height: 50,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text(
                          'Water temp',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey),
                        ),
                        Text(
                          readings?.tTemp.toDouble().toStringAsFixed(2) ?? '0',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: getHeight(context) * 0.05,
            ),
            Row(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/metering.png',
                      width: 50,
                      height: 50,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text(
                          'Farm Co2',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey),
                        ),
                        Text(
                          readings?.eCo2.toDouble().toStringAsFixed(2) ?? '0',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        )
                      ],
                    )
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/light-bulb.png',
                      width: 50,
                      height: 50,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text(
                          'Light Level',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey),
                        ),
                        Text(
                          readings?.lightLvl.toDouble().toStringAsFixed(2) ??
                              '0',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: getHeight(context) * 0.05,
            ),
            Row(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/humidity.png',
                      width: 50,
                      height: 50,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text(
                          'Farm humidity',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey),
                        ),
                        Text(
                          readings?.eHumidity.toDouble().toStringAsFixed(2) ??
                              '0',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        )
                      ],
                    )
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/sea-level.png',
                      width: 50,
                      height: 50,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text(
                          'Water Level',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey),
                        ),
                        Text(
                          readings?.tWaterLvl.toDouble().toStringAsFixed(2) ??
                              '0',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: getHeight(context) * 0.05,
            ),
            Row(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/ph.png',
                      width: 50,
                      height: 50,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text(
                          'Water PH',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey),
                        ),
                        Text(
                          readings?.tPh.toDouble().toStringAsFixed(2) ?? '0',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        )
                      ],
                    )
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/conductivity.png',
                      width: 50,
                      height: 50,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text(
                          'Water EC',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey),
                        ),
                        Text(
                          readings?.tEc.toDouble().toStringAsFixed(2) ?? '0',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        )
                      ],
                    )
                  ],
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
