import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

/* -- Light & Dark Elevated Button Themes -- */
class TElevatedButtonTheme {
  TElevatedButtonTheme._(); //To avoid creating instances


  /* -- Light Theme -- */
  static final lightElevatedButtonTheme  = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: CampusColors.light,
      backgroundColor: CampusColors.primary,
      disabledForegroundColor: CampusColors.darkGrey,
      disabledBackgroundColor: CampusColors.buttonDisabled,
      side: const BorderSide(color: CampusColors.primary),
      padding: const EdgeInsets.symmetric(vertical: CampusSizes.buttonHeight),
      textStyle: const TextStyle(fontSize: 16, color: CampusColors.textWhite, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(CampusSizes.buttonRadius)),
    ),
  );

  /* -- Dark Theme -- */
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: CampusColors.light,
      backgroundColor: CampusColors.primary,
      disabledForegroundColor: CampusColors.darkGrey,
      disabledBackgroundColor: CampusColors.darkerGrey,
      side: const BorderSide(color: CampusColors.primary),
      padding: const EdgeInsets.symmetric(vertical: CampusSizes.buttonHeight),
      textStyle: const TextStyle(fontSize: 16, color: CampusColors.textWhite, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(CampusSizes.buttonRadius)),
    ),
  );
}
