import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<User?> singUpWithEmailAndPassword(String emai, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: emai, password: password);
      return userCredential.user;
    } catch (e) {
      print("Some error Occured");
    }
    return null;
  }

  Future<User?> singInWithEmailAndPassword(String emai, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: emai, password: password);
      return userCredential.user;
    } catch (e) {
      print("Some error Occured");
    }
    return null;
  }
}
