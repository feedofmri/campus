import 'package:campus/postFeed/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

import '../login/Firebaseauth.dart';

class UserProvider with ChangeNotifier {
  UseR? _user;
  final FirebaseAuthService _authMethods = FirebaseAuthService();

  UseR get getUser => _user!;

  Future<void> refreshUser() async {
    UseR user = await _authMethods.getUserDetails();
    _user = user as UseR?;
    notifyListeners();
  }
}
