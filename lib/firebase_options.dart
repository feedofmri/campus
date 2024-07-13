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
    apiKey: 'AIzaSyAOhNHJBCczAOtS4NU23enMTlTjC2VdwX0',
    appId: '1:967627888068:web:8cbc788bbe014675abc091',
    messagingSenderId: '967627888068',
    projectId: 'campusadel-2980a',
    authDomain: 'campusadel-2980a.firebaseapp.com',
    storageBucket: 'campusadel-2980a.appspot.com',
    measurementId: 'G-196XK4T260',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCEhzf5i33NUBPCe56IHp5kOxE2GOyIkVQ',
    appId: '1:967627888068:android:e71c742ff26fadc2abc091',
    messagingSenderId: '967627888068',
    projectId: 'campusadel-2980a',
    storageBucket: 'campusadel-2980a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBPFkQZvCuUcs2TiPgRci1RHV-JpFegXLM',
    appId: '1:967627888068:ios:f4cb1e3dc22a5af1abc091',
    messagingSenderId: '967627888068',
    projectId: 'campusadel-2980a',
    storageBucket: 'campusadel-2980a.appspot.com',
    androidClientId: '967627888068-72k4r9camvsobf9otsoks201pdghctfe.apps.googleusercontent.com',
    iosClientId: '967627888068-95fo3d1nvj0t9edcu63be50879n9lb18.apps.googleusercontent.com',
    iosBundleId: 'dev.boraq.campus',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBPFkQZvCuUcs2TiPgRci1RHV-JpFegXLM',
    appId: '1:967627888068:ios:f4cb1e3dc22a5af1abc091',
    messagingSenderId: '967627888068',
    projectId: 'campusadel-2980a',
    storageBucket: 'campusadel-2980a.appspot.com',
    androidClientId: '967627888068-72k4r9camvsobf9otsoks201pdghctfe.apps.googleusercontent.com',
    iosClientId: '967627888068-95fo3d1nvj0t9edcu63be50879n9lb18.apps.googleusercontent.com',
    iosBundleId: 'dev.boraq.campus',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAOhNHJBCczAOtS4NU23enMTlTjC2VdwX0',
    appId: '1:967627888068:web:00ea6034989e39ddabc091',
    messagingSenderId: '967627888068',
    projectId: 'campusadel-2980a',
    authDomain: 'campusadel-2980a.firebaseapp.com',
    storageBucket: 'campusadel-2980a.appspot.com',
    measurementId: 'G-QD1LHTD1W2',
  );

}