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
    apiKey: 'AIzaSyBb_L8DTLzcWGP-v-3WQshEZpDM22tPOT8',
    appId: '1:451801507625:web:f72f94f746b8358bd07938',
    messagingSenderId: '451801507625',
    projectId: 'sarh-3efed',
    authDomain: 'sarh-3efed.firebaseapp.com',
    storageBucket: 'sarh-3efed.appspot.com',
    measurementId: 'G-03WL6JY5PX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCgcjK2E_ixq72pO10-pbzavlGNSqsBhyc',
    appId: '1:451801507625:android:492fc2e026a708cfd07938',
    messagingSenderId: '451801507625',
    projectId: 'sarh-3efed',
    storageBucket: 'sarh-3efed.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBaUm87OZpxgp5KKIv2ZeE_5d8FowzodIY',
    appId: '1:451801507625:ios:c55d57c56592c42dd07938',
    messagingSenderId: '451801507625',
    projectId: 'sarh-3efed',
    storageBucket: 'sarh-3efed.appspot.com',
    iosBundleId: 'com.example.sarh',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBaUm87OZpxgp5KKIv2ZeE_5d8FowzodIY',
    appId: '1:451801507625:ios:c55d57c56592c42dd07938',
    messagingSenderId: '451801507625',
    projectId: 'sarh-3efed',
    storageBucket: 'sarh-3efed.appspot.com',
    iosBundleId: 'com.example.sarh',
  );
}




