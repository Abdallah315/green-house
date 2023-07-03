import 'package:flutter/material.dart';
import 'package:green_house/models/plant.dart';
import 'package:green_house/presentation/screens/add_plant_to_farm_screen.dart';
import 'package:green_house/presentation/screens/sensor_readings_screen.dart';
import 'package:green_house/presentation/widgets/plant_container.dart';
import 'package:green_house/store/auth.dart';
import 'package:green_house/utils/constants.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import '../../store/farms.dart';

class InfoScreen extends StatefulWidget {
  final Map<String, dynamic> args;
  const InfoScreen({super.key, required this.args});
  static const routeName = '/info';

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  bool isloading = false;
  @override
  void initState() {
    super.initState();
    getAllUserPlants();
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
                  GestureDetector(
                      onTap: () => PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: SensorReadingsScreen(args: widget.args),
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino),
                      child: buildFarmData(context)),
                  SizedBox(
                    height: getHeight(context) * .04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Smart Greenhouse Plants',
                        style: TextStyle(
                            color: myDarkGreen,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                      GestureDetector(
                        onTap: () => PersistentNavBarNavigator.pushNewScreen(
                            context,
                            withNavBar: false,
                            screen: const AddPlantToFarmScreen()),
                        child: const Icon(
                          Icons.add,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                  Consumer<FarmStore>(
                    builder: (context, farmStore, child) {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          Plant plant = farmStore.allPlants[index];
                          return PlantContainer(plant: plant);
                        },
                        itemCount: farmStore.allPlants.length,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
      ),
    );
  }

  Widget buildFarmData(BuildContext context) {
    return Container(
      height: getHeight(context) * .15,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/wind.png',
              width: 25,
              height: 25,
            ),
            const SizedBox(
              height: 15,
            ),
            const Text('data')
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/tint.png',
              width: 25,
              height: 25,
            ),
            const SizedBox(
              height: 15,
            ),
            const Text('data')
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/tree.png',
              width: 25,
              height: 25,
            ),
            const SizedBox(
              height: 15,
            ),
            const Text('data')
          ],
        ),
      ]),
    );
  }
}
