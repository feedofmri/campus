import 'package:flutter/material.dart';
import 'User.dart'; // Ensure this import is correct for your user model
import 'All_chat.dart'; // Ensure this import is correct for your AllChat widget
import 'package:campus/utils/Style/ChatBottomSheet.dart';
import 'package:campus/utils/Style/All_chat.dart';

class ChatPage extends StatefulWidget {
  final UserX user;

  ChatPage({required this.user});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: Padding(
          padding: EdgeInsets.only(top: 5),
          child: AppBar(
            leadingWidth: 30,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(widget.user.image),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.user.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      widget.user.profession,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 25),
                child: Icon(
                  Icons.call,
                  color: Color(0xFF114953),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 25),
                child: Icon(
                  Icons.video_call,
                  color: Color(0xFF114953),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.more_vert,
                  color: Color(0xFF114953),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding:
                  EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
              children: [
                AllChat(user: widget.user),
                // Add more widgets here if necessary
              ],
            ),
          ),
          ChatBottomSheet(),
        ],
      ),
    );
  }
}
