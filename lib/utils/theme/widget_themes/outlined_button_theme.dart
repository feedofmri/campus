import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';

/* -- Light & Dark Outlined Button Themes -- */
class TOutlinedButtonTheme {
  TOutlinedButtonTheme._(); //To avoid creating instances


  /* -- Light Theme -- */
  static final lightOutlinedButtonTheme  = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: CampusColors.dark,
      side: const BorderSide(color: CampusColors.borderPrimary),
      textStyle: const TextStyle(fontSize: 16, color: CampusColors.black, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: CampusSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(CampusSizes.buttonRadius)),
    ),
  );

  /* -- Dark Theme -- */
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: CampusColors.light,
      side: const BorderSide(color: CampusColors.borderPrimary),
      textStyle: const TextStyle(fontSize: 16, color: CampusColors.textWhite, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: CampusSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(CampusSizes.buttonRadius)),
    ),
  );
}
