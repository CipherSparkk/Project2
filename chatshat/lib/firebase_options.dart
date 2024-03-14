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
    apiKey: 'AIzaSyB_xhmVpwFJ9DjH2AoXtSPR90QkEaRmdFQ',
    appId: '1:35187109647:web:4fd0868fa8fbabb5bc987a',
    messagingSenderId: '35187109647',
    projectId: 'chatshat-84f19',
    authDomain: 'chatshat-84f19.firebaseapp.com',
    storageBucket: 'chatshat-84f19.appspot.com',
    measurementId: 'G-TFL7FTFZY8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCMTMQhRkRUZPy4hIYdvBg71d6bZ4Ojhjc',
    appId: '1:35187109647:android:ada5f782840aa91abc987a',
    messagingSenderId: '35187109647',
    projectId: 'chatshat-84f19',
    storageBucket: 'chatshat-84f19.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAYEPMdqp5qgidp9CrADBqzft8jEhepaHc',
    appId: '1:35187109647:ios:b56cbe6829eb2cbebc987a',
    messagingSenderId: '35187109647',
    projectId: 'chatshat-84f19',
    storageBucket: 'chatshat-84f19.appspot.com',
    iosBundleId: 'com.example.chatshat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAYEPMdqp5qgidp9CrADBqzft8jEhepaHc',
    appId: '1:35187109647:ios:643aa688953bde16bc987a',
    messagingSenderId: '35187109647',
    projectId: 'chatshat-84f19',
    storageBucket: 'chatshat-84f19.appspot.com',
    iosBundleId: 'com.example.chatshat.RunnerTests',
  );
}