import 'package:campus/login/signup.dart';
import 'package:campus/utils/Style/nvigation.datr.dart';
import 'package:campus/utils/Style/welcome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constants/image_strings.dart';
import '../utils/constants/sizes.dart';
import '../utils/constants/text_strings.dart';
import '../utils/constants/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(
                top: CampusSizes.appBarHeight,
                left: CampusSizes.defaultSpace,
                right: CampusSizes.defaultSpace,
                bottom: CampusSizes.defaultSpace,
              ),
              child: Column(
                children: <Widget>[
                  // Logo and title
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Image(
                          height: 100,
                          image: AssetImage('assets/logos/campus-icon.png')),
                      Text(CampusTexts.loginTitle,
                          style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(height: CampusSizes.sm),
                      Text(CampusTexts.loginSubTitle,
                          style: Theme.of(context).textTheme.bodyMedium),
                      // Email and password fields
                      Form(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: CampusSizes.spaceBtwItems),
                          child: Column(
                            children: [
                              // Email field
                              TextFormField(
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.arrow_right),
                                    labelText: CampusTexts.email),
                              ),
                              const SizedBox(height: CampusSizes.spaceBtwItems),

                              // Password field
                              TextFormField(
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.password),
                                    labelText: CampusTexts.password,
                                    suffixIcon: Icon(Icons.visibility)),
                              ),
                              const SizedBox(
                                  height: CampusSizes.spaceBtwItems / 2),

                              // remember me and forget password
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Checkbox(
                                          value: true, onChanged: (value) {}),
                                      Text(CampusTexts.rememberMe,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium),
                                    ],
                                  ),
                                  TextButton(
                                      onPressed: () {},
                                      child: Text(CampusTexts.forgetPassword,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium)),
                                ],
                              ),
                              const SizedBox(height: CampusSizes.spaceBtwItems),

                              // signing button
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Navigation(),
                                        ));
                                  },
                                  child: const Text(CampusTexts.signIn),
                                ),
                              ),
                              const SizedBox(height: CampusSizes.spaceBtwItems),

                              // signup button
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton(
                                    onPressed: () =>
                                        Get.to(() => const SignupScreen()),
                                    child:
                                        const Text(CampusTexts.createAccount)),
                              ),
                              const SizedBox(height: CampusSizes.spaceBtwItems),
                            ],
                          ),
                        ),
                      ),
                      // divider
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Flexible(
                              child: Divider(
                            color: CampusColors.grey,
                            thickness: 0.5,
                            indent: 60,
                            endIndent: 5,
                          )),
                          Text(CampusTexts.orSignInWith.capitalize!,
                              style: Theme.of(context).textTheme.labelMedium),
                          const Flexible(
                            child: Divider(
                              color: CampusColors.grey,
                              thickness: 0.5,
                              indent: 5,
                              endIndent: 60,
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: CampusSizes.spaceBtwItems),

                      // social media buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: CampusColors.grey),
                                borderRadius: BorderRadius.circular(100)),
                            child: IconButton(
                              onPressed: () {},
                              icon: const Image(
                                  width: CampusSizes.iconMd,
                                  height: CampusSizes.iconMd,
                                  image: AssetImage(CampusImages.google)),
                            ),
                          ),
                          const SizedBox(width: CampusSizes.spaceBtwItems),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: CampusColors.grey),
                                borderRadius: BorderRadius.circular(100)),
                            child: IconButton(
                              onPressed: () {},
                              icon: const Image(
                                  width: CampusSizes.iconMd,
                                  height: CampusSizes.iconMd,
                                  image: AssetImage(CampusImages.facebook)),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ))),
    );
  }
}
