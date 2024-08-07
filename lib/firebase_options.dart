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
    apiKey: 'AIzaSyDnXbU3DPN8fOafzNInzLz-l3wHy0WCzIE',
    appId: '1:62294459893:web:8da2a42b7219d6b2a0ccbc',
    messagingSenderId: '62294459893',
    projectId: 'e-commerce-e2352',
    authDomain: 'e-commerce-e2352.firebaseapp.com',
    storageBucket: 'e-commerce-e2352.appspot.com',
    measurementId: 'G-Y1QBB1KN1M',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDbQ_s4C5s4ZUlG52YIhguFz-hVog4Kyyg',
    appId: '1:62294459893:android:e7677af122ec041ca0ccbc',
    messagingSenderId: '62294459893',
    projectId: 'e-commerce-e2352',
    storageBucket: 'e-commerce-e2352.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyByd22wyafJOKB0kyGkE0o2yljVvey3S5M',
    appId: '1:62294459893:ios:99682614810a7c1da0ccbc',
    messagingSenderId: '62294459893',
    projectId: 'e-commerce-e2352',
    storageBucket: 'e-commerce-e2352.appspot.com',
    androidClientId: '62294459893-0llkmc01is6lie2gmuu6o471lleofm2h.apps.googleusercontent.com',
    iosClientId: '62294459893-du9vpqhg3pk4ctvq1b1sue1pl42cudvm.apps.googleusercontent.com',
    iosBundleId: 'com.example.newapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyByd22wyafJOKB0kyGkE0o2yljVvey3S5M',
    appId: '1:62294459893:ios:29e1515a6cea3a88a0ccbc',
    messagingSenderId: '62294459893',
    projectId: 'e-commerce-e2352',
    storageBucket: 'e-commerce-e2352.appspot.com',
    androidClientId: '62294459893-0llkmc01is6lie2gmuu6o471lleofm2h.apps.googleusercontent.com',
    iosClientId: '62294459893-b87ni7m12qrairf006fh0fjdci7dmk36.apps.googleusercontent.com',
    iosBundleId: 'com.example.newapp.RunnerTests',
  );
}
