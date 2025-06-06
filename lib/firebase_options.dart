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
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyCyOUl9vVdLHeUU4B7eckeX9Tvzjz4EevA',
    appId: '1:339774004435:web:66e4eab7655a14f1754826',
    messagingSenderId: '339774004435',
    projectId: 'mybookstask',
    authDomain: 'mybookstask.firebaseapp.com',
    storageBucket: 'mybookstask.firebasestorage.app',
    measurementId: 'G-GJ5RQDQZX8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDwQuAf3x1hxuwFgkvSfusV3_K6dYdRYGo',
    appId: '1:339774004435:android:77a5002d878d2993754826',
    messagingSenderId: '339774004435',
    projectId: 'mybookstask',
    storageBucket: 'mybookstask.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD_NnSg-lkHlDgCk0Znk6RCv27iN-KDJJo',
    appId: '1:339774004435:ios:9ada1e87acdf8c8b754826',
    messagingSenderId: '339774004435',
    projectId: 'mybookstask',
    storageBucket: 'mybookstask.firebasestorage.app',
    iosClientId: '339774004435-874vvdptrifcbr9vaun2beicmug4ttoi.apps.googleusercontent.com',
    iosBundleId: 'com.example.bookStask',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD_NnSg-lkHlDgCk0Znk6RCv27iN-KDJJo',
    appId: '1:339774004435:ios:9ada1e87acdf8c8b754826',
    messagingSenderId: '339774004435',
    projectId: 'mybookstask',
    storageBucket: 'mybookstask.firebasestorage.app',
    iosClientId: '339774004435-874vvdptrifcbr9vaun2beicmug4ttoi.apps.googleusercontent.com',
    iosBundleId: 'com.example.bookStask',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCyOUl9vVdLHeUU4B7eckeX9Tvzjz4EevA',
    appId: '1:339774004435:web:363e5099ab302e1f754826',
    messagingSenderId: '339774004435',
    projectId: 'mybookstask',
    authDomain: 'mybookstask.firebaseapp.com',
    storageBucket: 'mybookstask.firebasestorage.app',
    measurementId: 'G-WHYG8YR3Y5',
  );
}
