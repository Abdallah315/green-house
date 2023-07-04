import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_house/presentation/screens/history_screen.dart';
import 'package:green_house/store/auth.dart';
import 'package:green_house/store/user_store.dart';
import 'package:green_house/utils/constants.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isloading = false;
  @override
  void initState() {
    super.initState();
    getAllUserPlants();
  }

  void getAllUserPlants() async {
    isloading = true;
    String token = await Provider.of<Auth>(context, listen: false).getToken();
    if (!mounted) return;
    Provider.of<UserStore>(context, listen: false)
        .getUserData(context, token)
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
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: getWidth(context) * .8,
                      height: getHeight(context) * .2,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15)),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          SvgPicture.asset('assets/images/guest.svg'),
                          Consumer<UserStore>(
                            builder: (context, userStore, child) {
                              return Text(
                                userStore.userName ?? 'Guest',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: myLightGreen),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getHeight(context) * .08,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            AppSettings.openNotificationSettings();
                          },
                          child: Container(
                            width: getWidth(context) * .96,
                            height: getHeight(context) * 0.08,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                      'assets/images/notification.svg'),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  const Text(
                                    'Notification',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            PersistentNavBarNavigator.pushNewScreen(context,
                                screen: HistoryScreen());
                          },
                          child: Container(
                            width: getWidth(context) * .96,
                            height: getHeight(context) * 0.08,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                      'assets/images/settings.svg'),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  const Text(
                                    'History',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: getWidth(context) * .96,
                          height: getHeight(context) * 0.08,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/images/help.svg'),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Text(
                                  'Help',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () => context.read<Auth>().logout(),
                          child: Container(
                            width: getWidth(context) * .96,
                            height: getHeight(context) * 0.08,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  SvgPicture.asset('assets/images/logout.svg'),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  const Text(
                                    'Logout',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
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
