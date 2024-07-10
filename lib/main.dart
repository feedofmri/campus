import 'package:campus/login/login.dart';
import 'package:campus/login/signup.dart';
import 'package:campus/utils/Style/Header_page.dart';
import 'package:campus/utils/Style/SettingsPage.dart';
import 'package:campus/utils/Style/institutions.dart';
import 'package:campus/utils/Style/massage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screen_ex/flutter_settings_screen_ex.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  // Initialize Settings with SharePreferenceCache
  await Settings.init(cacheProvider: SharePreferenceCache());

  runApp(const App());
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
        home: const LoginScreen(),
        getPages: [
          GetPage(name: '/login', page: () => const LoginScreen()),
          GetPage(name: '/signup', page: () => const SignupScreen()),
          GetPage(name: '/settings', page: () => Settingspage()),
        ],
      ),
    );
  }
}
