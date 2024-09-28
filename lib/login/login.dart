import 'dart:developer';
import 'dart:io';

import 'package:campus/api/apis.dart';
import 'package:campus/api/user_controller.dart';
import 'package:campus/helper/dialogs.dart';
import 'package:campus/login/Firebaseauth.dart';
import 'package:campus/login/signup.dart';
import 'package:campus/utils/Style/nvigation.datr.dart';
import 'package:campus/utils/Style/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../utils/constants/image_strings.dart';
import '../utils/constants/sizes.dart';
import '../utils/constants/text_strings.dart';
import '../utils/constants/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final UserController userController = Get.find(); // Find the UserController
  bool _isLoading = false;
  bool _obscurePassword = true; // Added variable to handle password visibility
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  _handleGoogleBtnClick() {
    //for showing progress bar
    Dialogs.showProgressBar(context);

    _signInWithGoogle().then((user) async {
      //for hiding progress bar
      Navigator.pop(context);

      if (user != null) {
        log('\nUser: ${user.user}');
        log('\nUserAdditionalInfo: ${user.additionalUserInfo}');
        String? email = user.user?.email;
        final userController = Get.put(UserController());
        userController.email(email ?? '');

        if (await APIs.userExists() && mounted) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => Navigation(),
              ));
        } else {
          await APIs.createUser().then((value) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => Navigation()));
          });
        }
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await APIs.auth.signInWithCredential(credential);
    } catch (e) {
      log('\n_signInWithGoogle: $e');

      if (mounted) {
        Dialogs.showSnackbar(context, 'Something Went Wrong (Check Internet!)');
      }

      return null;
    }
  }

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
                    image: AssetImage('assets/logos/campus-icon.png'),
                  ),
                  Text(
                    CampusTexts.loginTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: CampusSizes.sm),
                  Text(
                    CampusTexts.loginSubTitle,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  // Email and password fields
                  Form(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: CampusSizes.spaceBtwItems),
                      child: Column(
                        children: [
                          // Email field
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.arrow_right),
                              labelText: CampusTexts.email,
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: CampusSizes.spaceBtwItems),
                          // Password field
                          TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.password),
                              labelText: CampusTexts.password,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),
                            obscureText: _obscurePassword,
                          ),
                          const SizedBox(height: CampusSizes.spaceBtwItems / 2),
                          // Remember me and forget password
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Checkbox(value: true, onChanged: (value) {}),
                                  Text(
                                    CampusTexts.rememberMe,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  CampusTexts.forgetPassword,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: CampusSizes.spaceBtwItems),
                          // Sign-in button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _login,
                              child: _isLoading
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text(CampusTexts.signIn),
                            ),
                          ),
                          const SizedBox(height: CampusSizes.spaceBtwItems),
                          // Sign-up button
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () =>
                                  Get.to(() => const SignupScreen()),
                              child: const Text(CampusTexts.createAccount),
                            ),
                          ),
                          const SizedBox(height: CampusSizes.spaceBtwItems),
                        ],
                      ),
                    ),
                  ),
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
                        CampusTexts.orSignInWith.capitalize!,
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
                          onPressed: _handleGoogleBtnClick,
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
                            image: AssetImage(CampusImages.facebook),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in both fields'),
        ),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    User? user = await _auth.singInWithEmailAndPassword(email, password);

    if (user != null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Navigation()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login Failed'),
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }
}
