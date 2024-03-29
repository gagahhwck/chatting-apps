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
    apiKey: 'AIzaSyCEI4pNjo8ZAE06tWcaRsIzyQR6cZn7c74',
    appId: '1:750690646639:web:fe9591827c72f45fadeb9a',
    messagingSenderId: '750690646639',
    projectId: 'flash-chat-4e3cd',
    authDomain: 'flash-chat-4e3cd.firebaseapp.com',
    storageBucket: 'flash-chat-4e3cd.appspot.com',
    measurementId: 'G-YWRK1BMHTL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBntAzXo9z30qROM6lfcmTqKotH6ge-wY8',
    appId: '1:750690646639:android:a8f3379f34f93eadadeb9a',
    messagingSenderId: '750690646639',
    projectId: 'flash-chat-4e3cd',
    storageBucket: 'flash-chat-4e3cd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCdJf8k78IGCj3bv1tSVWgY_SWEGkDWTfY',
    appId: '1:750690646639:ios:0f304a017d4227d6adeb9a',
    messagingSenderId: '750690646639',
    projectId: 'flash-chat-4e3cd',
    storageBucket: 'flash-chat-4e3cd.appspot.com',
    iosBundleId: 'com.example.chatUi',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCdJf8k78IGCj3bv1tSVWgY_SWEGkDWTfY',
    appId: '1:750690646639:ios:e683d68f84ed9c8badeb9a',
    messagingSenderId: '750690646639',
    projectId: 'flash-chat-4e3cd',
    storageBucket: 'flash-chat-4e3cd.appspot.com',
    iosBundleId: 'com.example.chatUi.RunnerTests',
  );
}
