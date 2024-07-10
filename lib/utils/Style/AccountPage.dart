import 'package:campus/utils/Style/Iconwidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screen_ex/flutter_settings_screen_ex.dart';
import 'Utils.datr.dart';

class AccountPage extends StatelessWidget {
  static const keyLanguage = 'Key-Language';
  static const keyLocation = 'Key-Location';
  Widget build(BuildContext context) => SimpleSettingsTile(
        title: 'Account Setting',
        subtitle: 'Privacy, Security, Language',
        leading: IconWidget(icon: Icons.person, color: Colors.green),
        child: SettingsScreen(
          title: 'Account Settings',
          children: <Widget>[
            buildLanguage(),
            buildLocation(),
            buildPrivacy(context),
            buildSecurity(context),
            buildAccount(context),
          ],
        ),
      );
  Widget buildLanguage() => DropDownSettingsTile(
        settingKey: keyLanguage,
        title: 'Language',
        selected: 1,
        values: <int, String>{
          1: 'English',
          2: 'Spanish',
          3: 'Chinese',
          4: 'Hindi'
        },
        onChange: (language) {/*NOOP*/},
      );

  Widget buildLocation() => TextInputSettingsTile(
        settingKey: keyLocation,
        title: 'Location',
        initialValue: 'Australia',
        onChange: (location) {/* NOOP */},
      );

  Widget buildPrivacy(BuildContext context) => SimpleSettingsTile(
        title: 'Privacy',
        subtitle: '',
        leading: IconWidget(
          icon: Icons.lock,
          color: Colors.blueAccent,
        ),
        onTap: () => Utils.showSnackbar(context, 'Clicked Privacy'),
      );

  Widget buildSecurity(BuildContext context) => SimpleSettingsTile(
        title: 'Security',
        subtitle: '',
        leading: IconWidget(
          icon: Icons.security,
          color: Colors.red,
        ),
        onTap: () => Utils.showSnackbar(context, 'Clicked Security'),
      );

  Widget buildAccount(BuildContext context) => SimpleSettingsTile(
        title: 'AccountInfo',
        subtitle: '',
        leading: IconWidget(
          icon: Icons.text_snippet,
          color: Colors.purple,
        ),
        onTap: () => Utils.showSnackbar(context, 'Clicked Report Bug'),
      );
}
