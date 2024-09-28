import 'dart:typed_data';
import 'package:campus/utils/Style/Profile.dart';
import 'package:campus/utils/Style/User.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer';
import 'package:campus/api/user_controller.dart';
import 'package:campus/helper/add_profiledata.dart';

Future<Uint8List?> pickImage(ImageSource source) async {
  final ImagePicker picker = ImagePicker();
  XFile? file = await picker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  }
  log("No image is selected");
  return null;
}

class ProfileEdit extends StatefulWidget {
  final Function(Map<String, dynamic>) onSaveProfile;

  const ProfileEdit({required this.onSaveProfile, Key? key}) : super(key: key);

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  Uint8List? _image;
  final globalkey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController desigController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController intituteController = TextEditingController();
  final TextEditingController LinkedinController = TextEditingController();

  Future<void> selectImage_gallary() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    if (img != null) {
      setState(() {
        _image = img;
      });
    }
  }

  Future<void> selectImage_camera() async {
    Uint8List? image = await pickImage(ImageSource.camera);

    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          Text(
            "Select Image For Profile",
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: selectImage_camera,
                icon: Icon(
                  Icons.camera,
                  color: Colors.blue,
                ),
                iconSize: 36.00,
              ),
              SizedBox(
                height: 10,
                width: 15,
              ),
              IconButton(
                onPressed: selectImage_gallary,
                icon: Icon(
                  Icons.image,
                  color: const Color.fromARGB(255, 117, 33, 243),
                ),
                iconSize: 36.00,
              )
            ],
          )
        ],
      ),
    );
  }

  void saveProfile() async {
    if (globalkey.currentState?.validate() ?? false) {
      String name = nameController.text.trim();
      String desig = desigController.text.trim();
      String institution = intituteController.text.trim();
      String number = phoneController.text.trim();
      String address = addressController.text.trim();
      String linkedinId = LinkedinController.text.trim();

      if (_image != null) {
        try {
          final userController = Get.find<UserController>();
          String imageUrl = await StoreData().saveData(
            email: userController.email.value,
            name: name,
            desig: desig,
            institution: institution,
            address: address,
            number: number,
            linkdinId: linkedinId,
            file: _image!,
          );

          // Call the onSaveProfile callback with the profile data
          await userController.updateProfile(
            name: name,
            desig: desig,
            institution: institution,
            address: address,
            number: number,
            linkdinId: linkedinId,
            imageLink: imageUrl,
          );

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Profile saved successfully'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ));

          Navigator.pop(context);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Failed to save profile: $e'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Edit'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Stack(alignment: Alignment.bottomCenter, children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: _image != null
                      ? MemoryImage(_image!)
                      : AssetImage('assets/images/content/avatar.jpg')
                          as ImageProvider,
                  backgroundColor: Colors.grey[200],
                ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: ((builder) => bottomSheet()),
                      );
                    },
                    icon: Icon(Icons.add_a_photo),
                  ),
                ),
              ]),
              SizedBox(height: 20),
              Expanded(
                child: Form(
                  key: globalkey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Name is required';
                            }
                            return null;
                          },
                          controller: nameController,
                          decoration: InputDecoration(
                              labelText: 'Name',
                              hintText: 'Enter your Name',
                              contentPadding: EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Designation is required';
                            }
                            return null;
                          },
                          controller: desigController,
                          decoration: InputDecoration(
                              labelText: 'Designation',
                              hintText: 'Enter your Designation',
                              contentPadding: EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Phone number is required';
                            }
                            return null;
                          },
                          controller: phoneController,
                          decoration: InputDecoration(
                              labelText: 'Phone',
                              hintText: 'Enter your Phone Number',
                              contentPadding: EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Address is required';
                            }
                            return null;
                          },
                          controller: addressController,
                          decoration: InputDecoration(
                              labelText: 'Address',
                              hintText: 'Enter your Address',
                              contentPadding: EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Institution is required';
                            }
                            return null;
                          },
                          controller: intituteController,
                          decoration: InputDecoration(
                              labelText: 'Institute',
                              hintText: 'Enter your Institute name',
                              contentPadding: EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'LinkedIn ID is required';
                            }
                            return null;
                          },
                          controller: LinkedinController,
                          decoration: InputDecoration(
                              labelText: 'LinkedIn-ID',
                              hintText: 'Enter your LinkedIn-ID',
                              contentPadding: EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: ElevatedButton(
                            onPressed: () {
                              saveProfile();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Profile saved successfully'),
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Profile(
                                        email: userController.email.value)),
                              );
                            },
                            child: Text('Save Changes'),
                          ),
                        )
                      ],
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
}
