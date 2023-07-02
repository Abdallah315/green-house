import 'package:flutter/material.dart';
import 'package:green_house/presentation/screens/bottom_nav_bar.dart';
import 'package:green_house/presentation/screens/welcome_screen.dart';
import 'package:green_house/store/farms.dart';
import 'package:green_house/store/user_store.dart';
import 'package:green_house/utils/constants.dart';
import 'package:provider/provider.dart';

import 'store/auth.dart';
import 'utils/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider(
          create: (context) => FarmStore(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserStore(),
        )
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          title: 'Flutter Demo',
          home: auth.isAuth
              ? const BottomNavBarScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? CircularProgressIndicator(
                              color: myDarkGreen,
                            )
                          : const WelcomeScreen(),
                ),
          routes: routes,
        ),
      ),
    );
  }
}
