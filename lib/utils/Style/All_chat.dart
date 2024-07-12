import 'package:campus/utils/Style/User.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart'; // Make sure this file contains the definition for the 'user' list and the User cla

class AllChat extends StatelessWidget {
  final UserX user;

  AllChat({required this.user});

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 80),
          child: ClipPath(
            clipper: UpperNipMessageClipper(MessageType.receive),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(color: Color(0xFFE1E1E2), boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(3, 3),
                )
              ]),
              child: Text(
                "Hi,${user.name} how are you.What are you doing",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
