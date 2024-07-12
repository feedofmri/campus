import 'package:campus/login/Firebaseauth.dart';
import 'package:campus/login/login.dart';
import 'package:campus/utils/Style/nvigation.datr.dart';
import 'package:campus/utils/Style/welcome.dart';
import 'package:campus/utils/helpers/helper_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/constants/image_strings.dart';
import '../utils/constants/sizes.dart';
import '../utils/constants/text_strings.dart';
import '../utils/constants/colors.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = CampusHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: CampusSizes.appBarHeight,
            left: CampusSizes.defaultSpace,
            right: CampusSizes.defaultSpace,
            bottom: CampusSizes.defaultSpace,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                CampusTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: CampusSizes.spaceBtwSections),

              // Form
              Form(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              labelText: CampusTexts.firstName,
                            ),
                          ),
                        ),
                        const SizedBox(width: CampusSizes.spaceBtwItems),
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              labelText: CampusTexts.lastName,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: CampusSizes.spaceBtwItems),
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.alternate_email),
                        labelText: CampusTexts.username,
                      ),
                    ),
                    const SizedBox(height: CampusSizes.spaceBtwItems),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        labelText: CampusTexts.email,
                      ),
                    ),
                    const SizedBox(height: CampusSizes.spaceBtwItems),

                    // Phone number
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        labelText: CampusTexts.phoneNo,
                      ),
                    ),
                    const SizedBox(height: CampusSizes.spaceBtwItems),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.password),
                        labelText: CampusTexts.password,
                        suffixIcon: Icon(Icons.visibility),
                      ),
                    ),
                    const SizedBox(height: CampusSizes.spaceBtwItems),

                    // Terms and conditions
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            value: true,
                            onChanged: (value) {},
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Flexible(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '${CampusTexts.iAgreeTo} ',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                TextSpan(
                                  text: '${CampusTexts.privacyPolicy} ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .apply(
                                        color: dark
                                            ? CampusColors.white
                                            : CampusColors.primary,
                                        decoration: TextDecoration.underline,
                                        decorationColor: dark
                                            ? CampusColors.white
                                            : CampusColors.primary,
                                      ),
                                ),
                                TextSpan(
                                  text: '${CampusTexts.and} ',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                TextSpan(
                                  text: CampusTexts.termsOfUse,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .apply(
                                        color: dark
                                            ? CampusColors.white
                                            : CampusColors.primary,
                                        decoration: TextDecoration.underline,
                                        decorationColor: dark
                                            ? CampusColors.white
                                            : CampusColors.primary,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: CampusSizes.spaceBtwItems),

                    // Signup button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _signUp,
                        child: const Text(CampusTexts.createAccount),
                      ),
                    ),
                    const SizedBox(height: CampusSizes.spaceBtwItems),

                    // Divider
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Flexible(
                          child: Divider(
                            color: CampusColors.grey,
                            thickness: 0.5,
                            indent: 60,
                            endIndent: 5,
                          ),
                        ),
                        Text(
                          CampusTexts.orSignUpWith.capitalize!,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const Flexible(
                          child: Divider(
                            color: CampusColors.grey,
                            thickness: 0.5,
                            indent: 5,
                            endIndent: 60,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: CampusSizes.spaceBtwItems),

                    // Social media buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: CampusColors.grey),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Image(
                              width: CampusSizes.iconMd,
                              height: CampusSizes.iconMd,
                              image: AssetImage(CampusImages.google),
                            ),
                          ),
                        ),
                        const SizedBox(width: CampusSizes.spaceBtwItems),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: CampusColors.grey),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Image(
                                width: CampusSizes.iconMd,
                                height: CampusSizes.iconMd,
                                image: AssetImage(CampusImages.facebook)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    String username = _usernameController.text.toString();

    String email = _emailController.text.toString();
    String password = _passwordController.text.toString();

    User? user = await _auth.singUpWithEmailAndPassword(email, password);

    if (user != Null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Signup Failed'),
      ));
    }
  }
}
