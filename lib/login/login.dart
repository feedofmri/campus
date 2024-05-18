import 'package:flutter/material.dart';

import '../utils/constants/sizes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.only(
          top: CampusSizes.appBarHeight,
          left: CampusSizes.defaultSpace,
          right: CampusSizes.defaultSpace,
          bottom: CampusSizes.defaultSpace,
        ),
          child: Column(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image(
                      height: 100,
                      image: AssetImage('assets/images/logo.png')),
                ],
              )
            ],
          )
        )),
      );
  }
}