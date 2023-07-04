import 'package:flutter/material.dart';
import 'package:green_house/store/auth.dart';
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

class _ControlScreenState extends State<ControlScreen> {
  bool isloading = false;
  @override
  void initState() {
    super.initState();
    // getAllUserPlants();
    // fetchReadings();
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
    });
  }

  void getAllUserPlants() async {
    isloading = true;
    String token = await Provider.of<Auth>(context, listen: false).getToken();
    print(widget.args);
    if (!mounted) return;
    Provider.of<FarmStore>(context, listen: false)
        .getAllFarmPlants(context, token, widget.args['serialNumber'])
        .then((value) {
      setState(() {
        isloading = false;
      });
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
    return Container(
      width: getWidth(context) * .35,
      height: getHeight(context) * .15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Color(0xff1F3724),
      ),
      child: Column(children: []),
    );
  }
}
