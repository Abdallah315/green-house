// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAxgqGDunXY-_QS-JeTlzCS-IMi0t_Brhg',
    appId: '1:1092342696451:web:781e5e8cbad1b249da9c36',
    messagingSenderId: '1092342696451',
    projectId: 'greenhouse-ef892',
    authDomain: 'greenhouse-ef892.firebaseapp.com',
    storageBucket: 'greenhouse-ef892.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDzD-VadZufWPH3s8DhynUwo_aj_Z56OuY',
    appId: '1:1092342696451:android:f2c13d5260b16b02da9c36',
    messagingSenderId: '1092342696451',
    projectId: 'greenhouse-ef892',
    storageBucket: 'greenhouse-ef892.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCRC08U9CDPNJSRld9qkCli_CKLfECA8-A',
    appId: '1:1092342696451:ios:c845f4441c81f08bda9c36',
    messagingSenderId: '1092342696451',
    projectId: 'greenhouse-ef892',
    storageBucket: 'greenhouse-ef892.appspot.com',
    iosClientId: '1092342696451-9sht3eeh71f4su60p9i9kf3l1dhb6e1f.apps.googleusercontent.com',
    iosBundleId: 'com.example.greenHouse',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCRC08U9CDPNJSRld9qkCli_CKLfECA8-A',
    appId: '1:1092342696451:ios:c845f4441c81f08bda9c36',
    messagingSenderId: '1092342696451',
    projectId: 'greenhouse-ef892',
    storageBucket: 'greenhouse-ef892.appspot.com',
    iosClientId: '1092342696451-9sht3eeh71f4su60p9i9kf3l1dhb6e1f.apps.googleusercontent.com',
    iosBundleId: 'com.example.greenHouse',
  );
}
