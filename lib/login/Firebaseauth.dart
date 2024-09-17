import 'package:campus/postFeed/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../postFeed/UserModel.dart';

class FirebaseAuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UseR> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return UseR.fromSnap(documentSnapshot);
  }

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
