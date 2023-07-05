import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_house/presentation/screens/history_screen.dart';
import 'package:green_house/utils/constants.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'home_screen.dart';
import 'profile_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  PersistentTabController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        // bottomScreenMargin: 100,
        // confineInSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: false,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style15, // Choose the nav bar style with this property.
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      // const AddPlantToFarmScreen(),
      const HomeScreen(),
      // const ControlScreen(),
      const HistoryScreen(),
      // const InfoScreen(),
      const ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.home_outlined),
          title: "Home",
          activeColorPrimary: myLightGreen,
          inactiveColorPrimary: Colors.grey),
      // PersistentBottomNavBarItem(
      //     icon: const FaIcon(FontAwesomeIcons.sliders),
      //     title: ("Control"),
      //     activeColorPrimary: myLightGreen,
      //     inactiveColorPrimary: Colors.grey),
      PersistentBottomNavBarItem(
          icon: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                SvgPicture.asset('assets/images/centered_button.svg'),
                SvgPicture.asset('assets/images/scan.svg'),
              ]),
          activeColorPrimary: const Color(0xff1F3724),
          inactiveColorPrimary: Colors.grey),
      // PersistentBottomNavBarItem(
      //     icon: const Icon(Icons.info_outline),
      //     title: ("Info"),
      //     activeColorPrimary: myLightGreen,
      //     inactiveColorPrimary: Colors.grey),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.person_2_outlined),
          title: ("Profile"),
          activeColorPrimary: myLightGreen,
          inactiveColorPrimary: Colors.grey),
    ];
  }
}
