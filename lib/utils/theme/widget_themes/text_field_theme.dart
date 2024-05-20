import 'package:flutter/material.dart';
import 'package:campus/utils/constants/colors.dart';
import '../../constants/sizes.dart';

class TTextFormFieldTheme {
  TTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: CampusColors.darkGrey,
    suffixIconColor: CampusColors.darkGrey,
    // constraints: const BoxConstraints.expand(height: CampusSizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(fontSize: CampusSizes.fontSizeMd, color: CampusColors.black),
    hintStyle: const TextStyle().copyWith(fontSize: CampusSizes.fontSizeSm, color: CampusColors.black),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle().copyWith(color: CampusColors.black.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(CampusSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: CampusColors.grey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(CampusSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: CampusColors.grey),
    ),
    focusedBorder:const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(CampusSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: CampusColors.dark),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(CampusSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: CampusColors.warning),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(CampusSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: CampusColors.warning),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor: CampusColors.darkGrey,
    suffixIconColor: CampusColors.darkGrey,
    // constraints: const BoxConstraints.expand(height: CampusSizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(fontSize: CampusSizes.fontSizeMd, color: CampusColors.white),
    hintStyle: const TextStyle().copyWith(fontSize: CampusSizes.fontSizeSm, color: CampusColors.white),
    floatingLabelStyle: const TextStyle().copyWith(color: CampusColors.white.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(CampusSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: CampusColors.darkGrey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(CampusSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: CampusColors.darkGrey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(CampusSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: CampusColors.white),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(CampusSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: CampusColors.warning),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(CampusSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: CampusColors.warning),
    ),
  );
}
