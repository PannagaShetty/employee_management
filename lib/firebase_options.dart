// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBCQ6-zeeQmqHwAnNVDnbAKVaG2MCWUOWg',
    appId: '1:135681882994:web:60762395ad8ad504affbeb',
    messagingSenderId: '135681882994',
    projectId: 'employee-management-526ac',
    authDomain: 'employee-management-526ac.firebaseapp.com',
    storageBucket: 'employee-management-526ac.firebasestorage.app',
    measurementId: 'G-37G313KMKN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDXI9q56Vp41xiVFB5wmFKib-b_OI3ELbo',
    appId: '1:135681882994:android:41d91bce8a4dd9cdaffbeb',
    messagingSenderId: '135681882994',
    projectId: 'employee-management-526ac',
    storageBucket: 'employee-management-526ac.firebasestorage.app',
  );
}
