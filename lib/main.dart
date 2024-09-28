import 'package:campus/api/user_controller.dart';
import 'package:campus/firebase_options.dart';
import 'package:campus/login/login.dart';
import 'package:campus/api/apis.dart';
import 'package:campus/login/signup.dart';
import 'package:campus/postFeed/user_provider.dart';
import 'package:campus/utils/Style/Header_page.dart';
import 'package:campus/utils/Style/SettingsPage.dart';
import 'package:campus/utils/Style/institutions.dart';
import 'package:campus/utils/Style/massage.dart';
import 'package:campus/utils/Style/nvigation.datr.dart';
import 'package:campus/utils/Style/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_settings_screen_ex/flutter_settings_screen_ex.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart'; // Add this line to import the Provider package

late Size mq;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('userBox');

  await Settings.init(cacheProvider: SharePreferenceCache());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(UserController());
  debugPaintSizeEnabled = false;
  runApp(ProviderScope(
      child:
          MaterialApp(debugShowCheckedModeBanner: false, home: const App())));
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: const App());
  }
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  static const String title = 'My App';

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    final MediaQueryData mq = MediaQuery.of(context);
    return ValueChangeObserver<bool>(
      cacheKey: HeaderPage.keyDarkMode,
      defaultValue: true,
      builder: (_, isDarkMode, __) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: App.title,
        theme: isDarkMode
            ? ThemeData.dark().copyWith(
                primaryColor: Colors.teal,
                colorScheme: const ColorScheme.dark(
                  secondary: Colors.white,
                ),
                scaffoldBackgroundColor: const Color(0xFF170635),
                canvasColor: const Color(0xFF170635),
              )
            : ThemeData.light().copyWith(
                colorScheme: const ColorScheme.light(
                  secondary: Colors.black,
                ),
              ),
        home: APIs.auth.currentUser != null
            ? Navigation()
            : const LoginScreen(), // Directly return the widget instead of using Navigator
        getPages: [
          GetPage(name: '/login', page: () => const LoginScreen()),
          GetPage(name: '/signup', page: () => const SignupScreen()),
          GetPage(name: '/settings', page: () => Settingspage()),
        ],
      ),
    );
  }
}
