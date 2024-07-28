import 'dart:developer';
import 'dart:ui';

import 'package:campus/utils/Style/chat_page.dart';
import 'package:campus/utils/Style/All_chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'User.dart'; // Ensure this import is correct for your user model

class Massages1 extends StatefulWidget {
  @override
  _MassagesState createState() => _MassagesState();
}

class _MassagesState extends State<Massages1> {
  // Assuming `user` is a list of User objects, define it here

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.lightBlue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(200),
            child: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(
                    text: 'All',
                    icon: Icon(Icons.person),
                  ),
                  Tab(
                    text: 'Connected',
                    icon: Icon(Icons.mark_chat_read_rounded),
                  ),
                  Tab(
                    text: 'Community',
                    icon: Icon(Icons.people_alt),
                  ),
                ],
              ),
              flexibleSpace: Container(
                padding:
                    EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 3, bottom: 20),
                      child: Text(
                        "Find Your Friends",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                          wordSpacing: 2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 50),
                      width: MediaQuery.of(context).size.width,
                      height: 55,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search",
                          hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              buildListView(),
              buildListView(),
              buildListView(), // Placeholder for 'Community' tab
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListView() {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatPage(
                          user: user[index],
                        )),
              );
            },
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(user[index].image),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user[index].name,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        user[index].profession,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.add, color: Colors.deepOrange),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          height: 1,
          thickness: 1,
          indent: 72,
          endIndent: 16,
          color: Colors.grey[300],
        );
      },
      itemCount: user.length,
    );
  }
}

class UserX {
  final String name;
  final String profession;
  final String image;

  UserX({required this.name, required this.profession, required this.image});
}
