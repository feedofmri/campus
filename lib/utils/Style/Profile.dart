import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:campus/helper/profile_edit.dart';
import 'package:campus/api/user_controller.dart';

class Profile extends StatelessWidget {
  final String email;

  const Profile({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();

    // Call getProfileData to fetch user data
    userController.getProfileData();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.blueAccent),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileEdit(
                    onSaveProfile: (data) {
                      userController.updateProfile(
                        name: data['name'],
                        desig: data['designation'],
                        institution: data['institution'],
                        address: data['address'],
                        number: data['number'],
                        linkdinId: data['linkedinId'],
                        imageLink: data['profileImageUrl'],
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Obx(() {
                    final imageUrl = userController.imageLink.value;
                    ImageProvider imageProvider;
                    if (imageUrl.isNotEmpty) {
                      imageProvider = NetworkImage(imageUrl);
                    } else {
                      imageProvider =
                          AssetImage('assets/images/content/avatar.jpg');
                    }
                    return CircleAvatar(
                      radius: 70,
                      backgroundImage: imageProvider,
                      backgroundColor: Colors.grey[200],
                    );
                  }),
                ],
              ),
              SizedBox(height: 20),
              Obx(() => Text(
                    userController.name.value.isEmpty
                        ? 'Name'
                        : userController.name.value,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'AutumnFlowers-9YVZK.otf',
                    ),
                  )),
              SizedBox(height: 10),
              Obx(() => Text(
                    userController.desig.value.isEmpty
                        ? 'Designation'
                        : userController.desig.value,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey[700],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    infoRow(
                        Icons.school,
                        userController.institution.value.isEmpty
                            ? 'Institution'
                            : userController.institution.value),
                    infoRow(
                        Icons.location_city,
                        userController.address.value.isEmpty
                            ? 'Address'
                            : userController.address.value),
                    infoRow(
                        Icons.phone,
                        userController.number.value.isEmpty
                            ? 'Mobile-No'
                            : userController.number.value),
                    infoRow(Icons.mail, userController.email.value),
                    infoRow(
                        Icons.work,
                        userController.linkdinId.value.isEmpty
                            ? 'LinkedIn-ID'
                            : userController.linkdinId.value),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                child: Center(
                  child: Text(
                    'ABOUT',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black, width: 2),
                    gradient: LinearGradient(
                      colors: [
                        Colors.white12,
                        Colors.white38,
                        Colors.white54,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                        'Write Something about Yourself and your Work...',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey[800],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 30,
            color: Colors.blueAccent,
          ),
          SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
