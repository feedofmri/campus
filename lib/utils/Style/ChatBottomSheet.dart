import 'package:flutter/material.dart';

class Chatbottomsheet extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 10,
          offset: Offset(0, 3),
        )
      ]),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(
              Icons.add,
              color: Color(0xFF113953),
              size: 30,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: Icon(
              Icons.emoji_emotions_outlined,
              color: Color(0xFF113953),
              size: 30,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Container(
              alignment: Alignment.centerRight,
              width: 270,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Type your massage",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.send,
              color: Color(0xFF113953),
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
