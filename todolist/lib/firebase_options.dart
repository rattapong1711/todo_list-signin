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
    apiKey: 'AIzaSyBCcZrv3wxCczC_NgEYKrAnlKpqHcG-PIg',
    appId: '1:285853765810:web:ef88abaf7f6d312ff9f9ab',
    messagingSenderId: '285853765810',
    projectId: 'todolist-2b066',
    authDomain: 'todolist-2b066.firebaseapp.com',
    storageBucket: 'todolist-2b066.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD44x0DEq9eYXUeVyalexNMyfu5EovYbrE',
    appId: '1:285853765810:android:859612da2c01b498f9f9ab',
    messagingSenderId: '285853765810',
    projectId: 'todolist-2b066',
    storageBucket: 'todolist-2b066.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCsLMsFslkxn-kZFEUzOjB4ZVZw8TctU-Y',
    appId: '1:285853765810:ios:1d087504abb9190cf9f9ab',
    messagingSenderId: '285853765810',
    projectId: 'todolist-2b066',
    storageBucket: 'todolist-2b066.appspot.com',
    iosBundleId: 'com.example.todolist',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCsLMsFslkxn-kZFEUzOjB4ZVZw8TctU-Y',
    appId: '1:285853765810:ios:1d087504abb9190cf9f9ab',
    messagingSenderId: '285853765810',
    projectId: 'todolist-2b066',
    storageBucket: 'todolist-2b066.appspot.com',
    iosBundleId: 'com.example.todolist',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBCcZrv3wxCczC_NgEYKrAnlKpqHcG-PIg',
    appId: '1:285853765810:web:52b05af292d7a973f9f9ab',
    messagingSenderId: '285853765810',
    projectId: 'todolist-2b066',
    authDomain: 'todolist-2b066.firebaseapp.com',
    storageBucket: 'todolist-2b066.appspot.com',
  );
}
