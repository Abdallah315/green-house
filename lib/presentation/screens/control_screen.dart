import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_house/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../store/farms.dart';

class ControlScreen extends StatefulWidget {
  final Map<String, dynamic> args;
  const ControlScreen({super.key, required this.args});
  static const routeName = '/info';

  @override
  State<ControlScreen> createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen>
    with TickerProviderStateMixin {
  bool isloading = false;
  bool _fanSwitch = false;
  bool _lightSwitch = false;
  bool _airSwitch = false;
  bool _valveSwitch = false;
  bool _pumpSwitch = false;
  bool _pump1Switch = false;
  bool _pump2Switch = false;
  bool _pump3Switch = false;

  AnimationController? controller1;
  AnimationController? controller2;
  AnimationController? controller3;

  @override
  void initState() {
    super.initState();

    controller1 = AnimationController(
        vsync: this, duration: Duration(seconds: 1, milliseconds: 500));
    controller1?.addListener(() {
      setState(() {});
    });
    controller2 = AnimationController(
        vsync: this, duration: Duration(seconds: 1, milliseconds: 500));
    controller2?.addListener(() {
      setState(() {});
    });
    controller3 = AnimationController(
        vsync: this, duration: Duration(seconds: 1, milliseconds: 500));
    controller3?.addListener(() {
      setState(() {});
    });
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Control Your Farm',
                        style: TextStyle(
                            color: myDarkGreen,
                            fontWeight: FontWeight.w700,
                            fontSize: 22),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  buildControllers()
                ],
              ),
      ),
    );
  }

  buildControllers() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Container(
                width: getWidth(context) * .35,
                height: getHeight(context) * .15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Color(0xff1F3724),
                ),
                padding: EdgeInsets.all(10),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Fan',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      Image.asset(
                        'assets/images/fan.png',
                        width: 40,
                        height: 40,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CupertinoSwitch(
                    value: _fanSwitch,
                    onChanged: (value) async {
                      Provider.of<FarmStore>(context, listen: false)
                          .farmControl(
                            context,
                            widget.args['serialNumber'],
                            false,
                            'e_fan',
                            value == true ? 'on' : 'off',
                          )
                          .then((value) => print(value));
                      setState(() {
                        _fanSwitch = value;
                      });
                    },
                  ),
                ]),
              ),
            ),
            Center(
              child: Container(
                width: getWidth(context) * .35,
                height: getHeight(context) * .15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Color(0xff1F3724),
                ),
                padding: EdgeInsets.all(10),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Light',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      Image.asset(
                        'assets/images/light-bulb.png',
                        width: 40,
                        height: 40,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CupertinoSwitch(
                    value: _lightSwitch,
                    onChanged: (value) async {
                      Provider.of<FarmStore>(context, listen: false)
                          .farmControl(
                            context,
                            widget.args['serialNumber'],
                            false,
                            'e_light',
                            value == true ? 'on' : 'off',
                          )
                          .then((value) => print(value));
                      setState(() {
                        _lightSwitch = value;
                      });
                    },
                  ),
                ]),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Container(
                width: getWidth(context) * .35,
                height: getHeight(context) * .15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Color(0xff1F3724),
                ),
                padding: EdgeInsets.all(10),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Valve',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      Image.asset(
                        'assets/images/valve.png',
                        width: 40,
                        height: 40,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CupertinoSwitch(
                    value: _valveSwitch,
                    onChanged: (value) async {
                      Provider.of<FarmStore>(context, listen: false)
                          .farmControl(
                            context,
                            widget.args['serialNumber'],
                            false,
                            't_valve',
                            value == true ? 'on' : 'off',
                          )
                          .then((value) => print(value));
                      setState(() {
                        _valveSwitch = value;
                      });
                    },
                  ),
                ]),
              ),
            ),
            Center(
              child: Container(
                width: getWidth(context) * .35,
                height: getHeight(context) * .15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Color(0xff1F3724),
                ),
                padding: EdgeInsets.all(10),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Tank Pump',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      Image.asset(
                        'assets/images/pump.png',
                        width: 40,
                        height: 40,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CupertinoSwitch(
                    value: _pumpSwitch,
                    onChanged: (value) async {
                      Provider.of<FarmStore>(context, listen: false)
                          .farmControl(
                            context,
                            widget.args['serialNumber'],
                            false,
                            't_pump',
                            value == true ? 'on' : 'off',
                          )
                          .then((value) => print(value));
                      setState(() {
                        _pumpSwitch = value;
                      });
                    },
                  ),
                ]),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Container(
                width: getWidth(context) * .35,
                height: getHeight(context) * .15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Color(0xff1F3724),
                ),
                padding: EdgeInsets.all(10),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Tank Air',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      Image.asset(
                        'assets/images/fresh-air.png',
                        width: 40,
                        height: 40,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CupertinoSwitch(
                    value: _airSwitch,
                    onChanged: (value) async {
                      Provider.of<FarmStore>(context, listen: false)
                          .farmControl(
                            context,
                            widget.args['serialNumber'],
                            false,
                            't_air',
                            value == true ? 'on' : 'off',
                          )
                          .then((value) => print(value));
                      setState(() {
                        _airSwitch = value;
                      });
                    },
                  ),
                ]),
              ),
            ),
            Center(
              child: Container(
                width: getWidth(context) * .35,
                height: getHeight(context) * .15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Color(0xff1F3724),
                ),
                padding: EdgeInsets.all(10),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Solution 1',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      Image.asset(
                        'assets/images/water-pump.png',
                        width: 40,
                        height: 40,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                      onTapDown: (details) {
                        controller1?.forward();
                        Provider.of<FarmStore>(context, listen: false)
                            .farmControl(
                          context,
                          widget.args['serialNumber'],
                          false,
                          'pump1',
                          'on',
                        );
                      },
                      onTapUp: (details) {
                        if (controller1?.status == AnimationStatus.forward) {
                          controller1?.reverse();
                        }

                        Provider.of<FarmStore>(context, listen: false)
                            .farmControl(
                          context,
                          widget.args['serialNumber'],
                          false,
                          'pump1',
                          'off',
                        );
                      },
                      child:
                          Stack(alignment: Alignment.center, children: <Widget>[
                        CircularProgressIndicator(
                          value: 1.0,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                        CircularProgressIndicator(
                          value: controller1?.value,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                      ])
                      // CircleAvatar(
                      //     backgroundColor: Colors.white,
                      //     radius: 20,
                      //     child: CircleAvatar(
                      //       backgroundColor: Colors.green,
                      //       radius: 17,
                      //     )),
                      )
                ]),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Container(
                width: getWidth(context) * .35,
                height: getHeight(context) * .15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Color(0xff1F3724),
                ),
                padding: EdgeInsets.all(10),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Solution 2',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      Image.asset(
                        'assets/images/water-pump-2.png',
                        width: 40,
                        height: 40,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTapDown: (details) {
                      controller2?.forward();

                      Provider.of<FarmStore>(context, listen: false)
                          .farmControl(
                        context,
                        widget.args['serialNumber'],
                        false,
                        'pump2',
                        'on',
                      );
                    },
                    onTapUp: (details) {
                      if (controller2?.status == AnimationStatus.forward) {
                        controller2?.reverse();
                      }

                      Provider.of<FarmStore>(context, listen: false)
                          .farmControl(
                        context,
                        widget.args['serialNumber'],
                        false,
                        'pump2',
                        'off',
                      );
                    },
                    child:
                        Stack(alignment: Alignment.center, children: <Widget>[
                      CircularProgressIndicator(
                        value: 1.0,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                      CircularProgressIndicator(
                        value: controller2?.value,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      ),
                    ]),
                  )
                ]),
              ),
            ),
            Center(
              child: Container(
                width: getWidth(context) * .35,
                height: getHeight(context) * .15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Color(0xff1F3724),
                ),
                padding: EdgeInsets.all(10),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Solution 3',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      Image.asset(
                        'assets/images/water-pump-3.png',
                        width: 40,
                        height: 40,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTapDown: (details) {
                      controller3?.forward();

                      Provider.of<FarmStore>(context, listen: false)
                          .farmControl(
                        context,
                        widget.args['serialNumber'],
                        false,
                        'pump3',
                        'on',
                      );
                    },
                    onTapUp: (details) {
                      if (controller3?.status == AnimationStatus.forward) {
                        controller3?.reverse();
                      }

                      Provider.of<FarmStore>(context, listen: false)
                          .farmControl(
                        context,
                        widget.args['serialNumber'],
                        false,
                        'pump3',
                        'off',
                      );
                    },
                    child:
                        Stack(alignment: Alignment.center, children: <Widget>[
                      CircularProgressIndicator(
                        value: 1.0,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                      CircularProgressIndicator(
                        value: controller3?.value,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      ),
                    ]),
                  )
                  // CupertinoSwitch(
                  //   value: _pump3Switch,

                  //   onChanged: (value) async {
                  //     Provider.of<FarmStore>(context, listen: false)
                  //         .farmControl(
                  //           context,
                  //           widget.args['serialNumber'],
                  //           false,
                  //           'pump3',
                  //           value == true ? 'on' : 'off',
                  //         )
                  //         .then((value) => print(value));
                  //     setState(() {
                  //       _pump3Switch = value;
                  //     });
                  //   },
                  // ),
                ]),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
