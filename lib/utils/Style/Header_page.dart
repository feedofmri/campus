import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_settings_screen_ex/flutter_settings_screen_ex.dart';

import 'CustomSettings.dart';
import 'Iconwidget.dart';

class HeaderPage extends StatelessWidget {
  static const keyDarkMode = 'key-dark-mode';

  @override
  Widget build(BuildContext context) => Column(
        children: [
          buildHeader(),
          const SizedBox(height: 32),
          //buildUser(context),
          buildDarkMode(),
        ],
      );
  Widget buildDarkMode() => SwitchSettingsTile(
        settingKey: keyDarkMode,
        leading: IconWidget(
          icon: Icons.dark_mode,
          color: Color(0xFF642ef3),
        ), // IconWidget
        title: 'Dark Mode',
        onChange: (_) {},
      );
  Widget buildHeader() => CustomSettingsTile(
        title: 'Settings',
        onTap: () {
          // Handle the tap event
        },
      );
// SwitchSettingsTile
} // Column
