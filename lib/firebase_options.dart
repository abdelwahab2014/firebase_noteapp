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
    apiKey: 'AIzaSyDun0bOufWdXJ9QrWyPE3h5MG3jFyLO8v4',
    appId: '1:590671549171:web:3ebd0e726c08102e0f5d86',
    messagingSenderId: '590671549171',
    projectId: 'note-737e1',
    databaseURL:'https://note-737e1-default-rtdb.firebaseio.com/',
    authDomain: 'note-737e1.firebaseapp.com',
    storageBucket: 'note-737e1.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDmeEga5CnTZet5NXvCn10EZPGfuFWNt4U',
    appId: '1:590671549171:android:d6defd364ed1c1b40f5d86',
    databaseURL:'https://note-737e1-default-rtdb.firebaseio.com/',
    messagingSenderId: '590671549171',
    projectId: 'note-737e1',
    storageBucket: 'note-737e1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB6ANpuzL0DlMwnSCvJ0BIpUMmj2S05chA',
    appId: '1:590671549171:ios:804e17b9a29c23a80f5d86',
    messagingSenderId: '590671549171',
    projectId: 'note-737e1',
    databaseURL:'https://note-737e1-default-rtdb.firebaseio.com/',
    storageBucket: 'note-737e1.appspot.com',
    iosClientId: '590671549171-bgm3g630hvaggjem5glqh7qc8al1i9i7.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB6ANpuzL0DlMwnSCvJ0BIpUMmj2S05chA',
    appId: '1:590671549171:ios:804e17b9a29c23a80f5d86',
    messagingSenderId: '590671549171',
    databaseURL:'https://note-737e1-default-rtdb.firebaseio.com/',
    projectId: 'note-737e1',
    storageBucket: 'note-737e1.appspot.com',
    iosClientId: '590671549171-bgm3g630hvaggjem5glqh7qc8al1i9i7.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication1',
  );
}
