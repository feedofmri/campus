import 'package:campus/login/Firebaseauth.dart';
import 'package:campus/login/signup.dart';
import 'package:campus/utils/Style/nvigation.datr.dart';
import 'package:campus/utils/Style/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.password),
                              labelText: CampusTexts.password,
                              suffixIcon: Icon(Icons.visibility),
                            ),
                            obscureText: true,
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
