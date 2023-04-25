import 'package:flutter/material.dart';
import 'package:green_house/presentation/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

import 'bussiness_logic/auth.dart';
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
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          title: 'Flutter Demo',
          home:
              //  auth.isAuth
              // ?
              const WelcomeScreen()
          // : FutureBuilder(
          //     future: auth.tryAutoLogin(),
          //     builder: (ctx, authResultSnapshot) =>
          //         authResultSnapshot.connectionState ==
          //                 ConnectionState.waiting
          //             ? CircularProgressIndicator(
          //                 color: myGreen,
          //               )
          //             : const WelcomeScreen(),
          //   ),
          ,
          routes: routes,
        ),
      ),
    );
  }
}
