import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_house/utils/constants.dart';

import 'auth_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final CarouselController _controller = CarouselController();
  int _currentPage = 0;

  void onNext() {
    if (_currentPage >= 2) {
      _goToLoginScreen();
      return;
    }
    _controller.nextPage();
  }

  void onSkip() {
    _goToLoginScreen();
  }

  void _goToLoginScreen() {
    Navigator.of(context).pushNamed(AuthScreen.routName);
  }

  Widget currentStep(int i) {
    switch (i) {
      case 0:
        return WelcomeStep1(
            onNext: onNext, onSkip: onSkip, currentPage: _currentPage);
      case 1:
        return WelcomeStep2(
            onNext: onNext, onSkip: onSkip, currentPage: _currentPage);
      case 2:
        return WelcomeStep3(
            onNext: onNext, onSkip: onSkip, currentPage: _currentPage);
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CarouselSlider(
          carouselController: _controller,
          options: CarouselOptions(
            height: getHeight(context),
            enableInfiniteScroll: false,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(
                () {
                  _currentPage = index;
                },
              );
            },
            enlargeCenterPage: false,
          ),
          items: [0, 1, 2].map((i) {
            return Builder(
              builder: (context) {
                return SizedBox(
                  width: getWidth(context),
                  child: currentStep(i),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

class WelcomeStep1 extends Step {
  WelcomeStep1({Key? key, onNext, onSkip, currentPage})
      : super(
            key: key,
            onNext: onNext,
            onSkip: onSkip,
            backgroundImage: "assets/images/welcome 1.svg",
            currentPage: currentPage,
            title: "Watering without worry",
            subtitle:
                'you can set your schedule watering plant properly and can exchange schedule automatically if come a bad climate');
}

class WelcomeStep2 extends Step {
  WelcomeStep2({Key? key, onNext, onSkip, currentPage})
      : super(
            key: key,
            onNext: onNext,
            onSkip: onSkip,
            backgroundImage: "assets/images/welcome 2.svg",
            currentPage: currentPage,
            title: "Get Information About Your Plants",
            subtitle:
                "you can scan information of your plant or a pest that harm your plant and get information how to take care that problems.");
}

class WelcomeStep3 extends Step {
  WelcomeStep3({Key? key, onNext, onSkip, currentPage})
      : super(
            key: key,
            onNext: onNext,
            onSkip: onSkip,
            backgroundImage: "assets/images/welcome 3.svg",
            currentPage: currentPage,
            title: "Build & Share with Community",
            subtitle:
                'You can create group or community of your garden or community in your city. And you can also trade, lend, buy, or share any goods with other people');
}

class Step extends StatelessWidget {
  final VoidCallback? onNext;
  final VoidCallback? onSkip;
  final String? backgroundImage;
  final String? title;
  final String? subtitle;
  int? currentPage;

  Step(
      {super.key,
      this.onNext,
      this.onSkip,
      this.backgroundImage,
      this.title,
      this.currentPage,
      this.subtitle});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: getHeight(context) * .5,
          child: SvgPicture.asset(
            backgroundImage!,
          ),
        ),
        SizedBox(
          height: getHeight(context) * .05,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            title!,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            subtitle!,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
          ),
        ),
        SizedBox(
          height: getHeight(context) * .1,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: ElevatedButton(
            onPressed: onNext,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35)),
              minimumSize: const Size.fromHeight(60),
              backgroundColor: const Color(0xff3F991A),
              elevation: 5,
            ),
            child: Text(
              currentPage! > 1 ? 'Let\'s Start' : "Next",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
        currentPage! > 1
            ? const SizedBox()
            : TextButton(
                onPressed: onSkip,
                child: const Text(
                  "Skip",
                  style: TextStyle(color: Color(0xff3F991A)),
                ))
      ],
    );
  }
}
