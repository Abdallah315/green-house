import 'package:flutter/material.dart';
import 'package:green_house/presentation/screens/add_farm_screen.dart';
import 'package:green_house/presentation/screens/info_screen.dart';
import 'package:green_house/store/auth.dart';
import 'package:green_house/store/farms.dart';
import 'package:green_house/store/user_store.dart';
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

class _HomeScreenState extends State<HomeScreen> {
  bool isloading = false;
  final TextEditingController _controller = TextEditingController();
  List<Farm>? filteredList;

  @override
  void initState() {
    super.initState();
    Provider.of<Auth>(context, listen: false)
        .getToken()
        .then((value) => print(value));
    getAllUserFarms();
  }

  void getAllUserFarms() async {
    isloading = true;
    String token = await Provider.of<Auth>(context, listen: false).getToken();
    if (!mounted) return;
    context.read<UserStore>().getUserData(context, token);
    Provider.of<FarmStore>(context, listen: false)
        .getAllFarms(context, token)
        .whenComplete(
      () {
        setState(
          () {
            isloading = false;
          },
        );
      },
    );
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
                          child: Consumer<UserStore>(
                            builder: (context, userStore, child) {
                              return Text(
                                'Hello , ${userStore.userName}',
                                style: TextStyle(
                                    color: myYellow,
                                    fontSize: 23,
                                    fontWeight: FontWeight.w700),
                              );
                            },
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
                              hintText: 'Search',
                              prefixIcon: Icon(
                                Icons.search,
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
                              return null;
                            },
                            controller: _controller,
                            onChanged: (value) {
                              filteredList =
                                  Provider.of<FarmStore>(context, listen: false)
                                      .allFarms;
                              filteredList = filteredList
                                  ?.where((element) =>
                                      element.name.contains(_controller.text))
                                  .toList();
                              setState(() {});
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
                              '${context.watch<FarmStore>().allFarms.length} places',
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
                context.read<FarmStore>().allFarms.isEmpty
                    ? Positioned(
                        top: 210,
                        right: 35,
                        child: GestureDetector(
                          onTap: () => PersistentNavBarNavigator.pushNewScreen(
                              context,
                              withNavBar: false,
                              screen: const AddFarmScreen(),
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino),
                          child: Container(
                              width: getWidth(context) * .8,
                              height: getHeight(context) * .29,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                    size: 180,
                                    color: Colors.grey.shade400,
                                  ),
                                  Text(
                                    'Add Farm',
                                    style: TextStyle(
                                        color: Colors.grey.shade400,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              )),
                        ),
                      )
                    : Positioned(
                        top: 200,
                        child: SizedBox(
                          width: getWidth(context),
                          height: getHeight(context) * .65,
                          child: Consumer<FarmStore>(
                            builder: (context, farmStore, child) {
                              return ListView.builder(
                                  itemBuilder: (context, index) {
                                    if (index == farmStore.allFarms.length) {
                                      return Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () => PersistentNavBarNavigator
                                                .pushNewScreen(context,
                                                    screen:
                                                        const AddFarmScreen(),
                                                    pageTransitionAnimation:
                                                        PageTransitionAnimation
                                                            .cupertino),
                                            child: Center(
                                              child: Container(
                                                  width: getWidth(context) * .8,
                                                  height:
                                                      getHeight(context) * .2,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: Colors
                                                              .grey.shade400)),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.add,
                                                        size: 120,
                                                        color: Colors
                                                            .grey.shade400,
                                                      ),
                                                      Text(
                                                        'Add Farm',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey.shade400,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      )
                                                    ],
                                                  )),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          )
                                        ],
                                      );
                                    } else {
                                      Farm farm = _controller.text.isEmpty
                                          ? farmStore.allFarms[index]
                                          : filteredList![index];
                                      return buildFarmComponent(
                                          context,
                                          farm.name,
                                          farm.plants.length.toString(),
                                          farmStore
                                              .allFarms[index].serialNumber);
                                    }
                                  },
                                  itemCount: _controller.text.isEmpty
                                      ? farmStore.allFarms.length + 1
                                      : filteredList!.length);
                            },
                          ),
                        ),
                      ),
              ],
            ],
          ),
        ));
  }

  Widget buildFarmComponent(BuildContext context, String title,
      String plantsNumber, String serialNumber) {
    return GestureDetector(
      onTap: () => PersistentNavBarNavigator.pushNewScreen(context,
          screen: InfoScreen(args: {
            'serialNumber': serialNumber,
          }),
          withNavBar: false,
          // settings: RouteSettings(arguments: {
          //   'serialNumber': serialNumber,
          // }),
          pageTransitionAnimation: PageTransitionAnimation.cupertino),
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
          ),
        ],
      ),
    );
  }
}
