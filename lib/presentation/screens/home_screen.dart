import 'package:flutter/material.dart';
import 'package:green_house/presentation/screens/info_screen.dart';
import 'package:green_house/store/auth.dart';
import 'package:green_house/store/farms.dart';
import 'package:green_house/utils/constants.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import '../../models/farm.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  bool isloading = false;

  @override
  void initState() {
    super.initState();
    getAllUserFarms();
  }

  void getAllUserFarms() async {
    isloading = true;
    String token = await Provider.of<Auth>(context, listen: false).getToken();
    Provider.of<FarmStore>(context, listen: false)
        .getAllFarms(context, token)
        .then((value) {
      setState(() {
        isloading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          width: getWidth(context),
          height: getHeight(context),
          child: Stack(
            children: [
              Container(
                width: getWidth(context),
                height: getHeight(context) * .35,
                decoration: BoxDecoration(
                    color: myDarkGreen,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50))),
              ),
              if (isloading)
                Center(
                    child: CircularProgressIndicator(
                  color: myLightGreen,
                ))
              else ...[
                Positioned(
                  top: 40,
                  child: Container(
                    width: getWidth(context),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Hello ,User',
                            style: TextStyle(
                                color: myYellow,
                                fontSize: 23,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(
                          height: getHeight(context) * .03,
                        ),
                        SizedBox(
                          width: getWidth(context) * .75,
                          child: TextFormField(
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white.withOpacity(.45),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(
                                      color: Colors.white.withOpacity(.45))),
                              hintText: 'First Name',
                              prefixIcon: Icon(
                                Icons.person_outline,
                                color: myDarkGreen,
                                size: 28,
                              ),
                              hintStyle: TextStyle(color: myDarkGreen),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(
                                      color: Colors.white.withOpacity(.45))),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Invalid Name';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              // _authData['firstName'] = value.toString();
                            },
                          ),
                        ),
                        SizedBox(
                          height: getHeight(context) * .03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Your GreenHouses',
                              style: TextStyle(
                                  color: Colors.green.shade100,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 23),
                            ),
                            Text(
                              '${context.read<FarmStore>().allFarms.length} places',
                              style: TextStyle(
                                  color: Colors.green.shade300,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 23),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 200,
                  child: SizedBox(
                      width: getWidth(context),
                      height: getHeight(context) * .65,
                      child: Consumer<FarmStore>(
                          builder: (context, farmStore, child) {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            Farm farm = farmStore.allFarms[index];
                            return buildFarmComponent(context, farm.name,
                                farm.plants.length.toString());
                          },
                          itemCount: farmStore.allFarms.length,
                        );
                      })),
                )
              ]
            ],
          ),
        ));
  }

  Widget buildFarmComponent(
      BuildContext context, String title, String plantsNumber) {
    return GestureDetector(
      onTap: () => PersistentNavBarNavigator.pushNewScreen(context,
          screen: const InfoScreen(),
          pageTransitionAnimation: PageTransitionAnimation.sizeUp),
      child: Column(
        children: [
          Image.asset('assets/images/photo.png'),
          SizedBox(
            height: getHeight(context) * .005,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 23,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                plantsNumber,
                style: TextStyle(
                    color: myLightGreen,
                    fontSize: 23,
                    fontWeight: FontWeight.w700),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
