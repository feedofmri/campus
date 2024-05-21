import 'package:flutter/material.dart';
import 'package:campus/utils/constants/image_strings.dart';
import 'package:campus/utils/constants/text_strings.dart';
import 'package:campus/utils/helpers/helper_functions.dart';

import '../../constants/sizes.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Horizontal Scrollable Pages
          PageView(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Image(
                      width: CampusHelperFunctions.screenWidth() * 8.8,
                      height: CampusHelperFunctions.screenHeight() * 8.6,
                      image: const AssetImage(CampusImages.onBoardingImage1),
                    ), // Image

                    Text(
                      CampusTexts.onBoardingTitle1,
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: CampusSizes.spaceBtwItems),
                    Text(
                      CampusTexts.onBoardingTitle1,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ], // Column Children
                ), // Column
              ), // SingleChildScrollView
            ], // PageView Children
          ), // PageView
        ], // Stack Children
      ), // Stack
    ); // Scaffold
  }
}