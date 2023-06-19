import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:green_house/presentation/screens/control_screen.dart';
import 'package:green_house/presentation/screens/info_screen.dart';
import 'package:green_house/utils/constants.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'camera_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  PersistentTabController? _controller;
  var qrstr = "Press to Scan";

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
      const ControlScreen(),
      const CameraScreen(),
      const InfoScreen(),
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
      PersistentBottomNavBarItem(
          icon: const FaIcon(FontAwesomeIcons.sliders),
          title: ("Control"),
          activeColorPrimary: myLightGreen,
          inactiveColorPrimary: Colors.grey),
      PersistentBottomNavBarItem(
          icon: InkWell(
            onTap: scanQr,
            child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset('assets/images/centered_button.svg'),
                  SvgPicture.asset('assets/images/scan.svg'),
                ]),
          ),
          activeColorPrimary: const Color(0xff1F3724),
          inactiveColorPrimary: Colors.grey),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.info_outline),
          title: ("Info"),
          activeColorPrimary: myLightGreen,
          inactiveColorPrimary: Colors.grey),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.person_2_outlined),
          title: ("Profile"),
          activeColorPrimary: myLightGreen,
          inactiveColorPrimary: Colors.grey),
    ];
  }

  Future<void> scanQr() async {
    try {
      FlutterBarcodeScanner.scanBarcode('#2A99CF', 'cancel', true, ScanMode.QR)
          .then((qrValue) async {
        if (qrValue != '-1') {
          showSuccessBottomSheet(context, qrValue);
        } else {
          setState(() {
            qrstr = 'unable to read this';
          });
          showFailureBottomSheet(context);
        }
      });
    } catch (e) {
      setState(() {
        qrstr = 'unable to read this';
      });
      showFailureBottomSheet(context);
    }
  }

  Future<void> showSuccessBottomSheet(
    context,
    String val,
  ) async {
    await showModalBottomSheet(
      context: context,
      isDismissible: true,
      enableDrag: true,
      useRootNavigator: true,
      builder: (context) => Material(
        color: Colors.white,
        child: StatefulBuilder(
          builder: (ctx, setState) => Container(
            height: getHeight(ctx) / 2.3,
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Lottie.asset('assets/images/green check-mark.json',
                      width: 140, height: 140),
                  Text(
                    'Your Serial number is: $val',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff171d22),
                      fixedSize: Size(MediaQuery.of(context).size.width * 0.7,
                          MediaQuery.of(context).size.height * 0.08),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                    ),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: val)).then(
                        (value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: myDarkGreen,
                              content: const Text(
                                'Copied Successfully',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            ),
                          );
                        },
                      ).whenComplete(
                        () => Navigator.of(ctx, rootNavigator: true).pop(),
                      );
                    },
                    // Navigator.of(ctx, rootNavigator: true).pop(),
                    child: const Text(
                      "Copy",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  Future<void> showFailureBottomSheet(
    context,
  ) async {
    await showModalBottomSheet(
      context: context,
      isDismissible: true,
      enableDrag: true,
      useRootNavigator: true,
      builder: (context) => Material(
        color: Colors.white,
        child: StatefulBuilder(
          builder: (ctx, setState) => Container(
            height: getHeight(ctx) / 2.3,
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.close_outlined,
                    size: 70,
                    color: Colors.red,
                  ),
                  const Text(
                    'Something went wrong,please try again',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff171d22),
                      fixedSize: Size(MediaQuery.of(context).size.width * 0.7,
                          MediaQuery.of(context).size.height * 0.08),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                    ),
                    onPressed: () =>
                        Navigator.of(ctx, rootNavigator: true).pop(),
                    child: const Text(
                      "close",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
