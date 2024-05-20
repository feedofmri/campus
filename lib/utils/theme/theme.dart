import 'package:flutter/material.dart';
import 'package:campus/utils/theme/widget_themes/appbar_theme.dart';
import 'package:campus/utils/theme/widget_themes/bottom_sheet_theme.dart';
import 'package:campus/utils/theme/widget_themes/checkbox_theme.dart';
import 'package:campus/utils/theme/widget_themes/chip_theme.dart';
import 'package:campus/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:campus/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:campus/utils/theme/widget_themes/text_field_theme.dart';
import 'package:campus/utils/theme/widget_themes/text_theme.dart';

import '../constants/colors.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: CampusColors.grey,
    brightness: Brightness.light,
    primaryColor: CampusColors.primary,
    textTheme: TTextTheme.lightTextTheme,
    chipTheme: TChipTheme.lightChipTheme,
    scaffoldBackgroundColor: CampusColors.white,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: CampusColors.grey,
    brightness: Brightness.dark,
    primaryColor: CampusColors.primary,
    textTheme: TTextTheme.darkTextTheme,
    chipTheme: TChipTheme.darkChipTheme,
    scaffoldBackgroundColor: CampusColors.black,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
  );
}
