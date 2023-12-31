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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyC2OevLJ0MEGtPmHg2k3qf-LzQLBQcY3uU',
    appId: '1:93822977761:web:4a50802c290f2d3cafd9a0',
    messagingSenderId: '93822977761',
    projectId: 'descarte-b78a4',
    authDomain: 'descarte-b78a4.firebaseapp.com',
    storageBucket: 'descarte-b78a4.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDlcV0-nh0i-N7HtJNO909c1VZftxJ2iZ0',
    appId: '1:93822977761:android:1b5cd9516c7bc90cafd9a0',
    messagingSenderId: '93822977761',
    projectId: 'descarte-b78a4',
    storageBucket: 'descarte-b78a4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBk0TKX5Ut_HW1cT721KLEWHY_kD1W_VQU',
    appId: '1:93822977761:ios:ebffad3f7d153395afd9a0',
    messagingSenderId: '93822977761',
    projectId: 'descarte-b78a4',
    storageBucket: 'descarte-b78a4.appspot.com',
    androidClientId: '93822977761-5i731bapkjdtufp5mq5fi64qng0456n3.apps.googleusercontent.com',
    iosClientId: '93822977761-j222rrij7kqpah20vlso63i1d18i30u9.apps.googleusercontent.com',
    iosBundleId: 'br.uff.descarte',
  );
}
