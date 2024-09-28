import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserController extends GetxController {
  var email = ''.obs;
  var name = ''.obs;
  var desig = ''.obs;
  var institution = ''.obs;
  var address = ''.obs;
  var number = ''.obs;
  var linkdinId = ''.obs;
  var imageLink = ''.obs;

  @override
  void onInit() {
    super.onInit();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      email.value = user.email ?? '';
      loadUserData(user.email ?? '');
    }
  }

  void loadUserData(String userEmail) async {
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail)
        .get();

    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
      name.value = data['name'] ?? '';
      desig.value = data['designation'] ?? '';
      institution.value = data['institution'] ?? '';
      address.value = data['address'] ?? '';
      number.value = data['number'] ?? '';
      linkdinId.value = data['linkedinId'] ?? '';
      imageLink.value = data['profileImageUrl'] ?? '';
    }
  }

  Future<void> updateProfile({
    required String name,
    required String desig,
    required String institution,
    required String address,
    required String number,
    required String linkdinId,
    required String imageLink,
  }) async {
    try {
      String userEmail = FirebaseAuth.instance.currentUser?.email ?? '';
      if (userEmail.isNotEmpty) {
        // Update the Firestore database with the new data
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userEmail)
            .set({
          'name': name,
          'designation': desig,
          'institution': institution,
          'address': address,
          'number': number,
          'linkedinId': linkdinId,
          'profileImageUrl': imageLink,
        }, SetOptions(merge: true));

        // Update the local observables with the new data
        this.name.value = name;
        this.desig.value = desig;
        this.institution.value = institution;
        this.address.value = address;
        this.number.value = number;
        this.linkdinId.value = linkdinId;
        this.imageLink.value = imageLink;
      } else {
        print('User email not found.');
      }
    } catch (e) {
      print('Error updating profile: $e');
    }
  }

  Future<void> getProfileData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userEmail = user.email ?? '';
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userEmail)
          .get();

      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        name.value = data['name'] ?? '';
        desig.value = data['designation'] ?? '';
        institution.value = data['institution'] ?? '';
        address.value = data['address'] ?? '';
        number.value = data['number'] ?? '';
        linkdinId.value = data['linkedinId'] ?? '';
        imageLink.value = data['profileImageUrl'] ?? '';
      }
    }
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    clearLocalData();
  }

  void clearLocalData() {
    name.value = '';
    desig.value = '';
    institution.value = '';
    address.value = '';
    number.value = '';
    linkdinId.value = '';
    imageLink.value = '';
  }

  // toJson function to convert user data to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'email': email.value,
      'name': name.value,
      'designation': desig.value,
      'institution': institution.value,
      'address': address.value,
      'number': number.value,
      'linkedinId': linkdinId.value,
      'profileImageUrl': imageLink.value,
    };
  }
}
