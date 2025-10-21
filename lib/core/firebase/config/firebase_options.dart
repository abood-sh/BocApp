import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  const DefaultFirebaseOptions._();

  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBwjcXbHcX_ihCpF1epcmowM9J9W7AdB1g',
    appId: '1:321253441126:android:3dd31da1dae243cd1337a7',
    messagingSenderId:
        '321253441126', // project_number from google-services.json
    projectId: 'doc-doc-54eec',
    storageBucket: 'doc-doc-54eec.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDZncL5tlmyg_nTI2ppN_Tq-wgZcMl84m0',
    appId: '1:321253441126:ios:81638342d96b4a771337a7',
    messagingSenderId: '321253441126',
    projectId: 'doc-doc-54eec',
    storageBucket: 'doc-doc-54eec.firebasestorage.app',
    iosBundleId: 'com.example.doc',
  );
}
