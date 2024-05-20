import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class TChipTheme {
  TChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: CampusColors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: CampusColors.black),
    selectedColor: CampusColors.primary,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: CampusColors.white,
  );

  static ChipThemeData darkChipTheme = const ChipThemeData(
    disabledColor: CampusColors.darkerGrey,
    labelStyle: TextStyle(color: CampusColors.white),
    selectedColor: CampusColors.primary,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: CampusColors.white,
  );
}
