import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StoreData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> saveData({
    required String email,
    required String name,
    required String desig,
    required String institution,
    required String address,
    required String number,
    required String linkdinId,
    required Uint8List file,
  }) async {
    try {
      Reference ref = _storage.ref().child('profileImages').child(email);
      UploadTask uploadTask = ref.putData(file);
      TaskSnapshot taskSnapshot = await uploadTask;
      String profileImageUrl = await taskSnapshot.ref.getDownloadURL();

      await _firestore.collection('users').doc(email).set({
        'name': name,
        'designation': desig,
        'institution': institution,
        'address': address,
        'number': number,
        'linkedinId': linkdinId,
        'profileImageUrl': profileImageUrl,
      });

      return profileImageUrl;
    } catch (e) {
      throw Exception('Failed to save profile: $e');
    }
  }
}
