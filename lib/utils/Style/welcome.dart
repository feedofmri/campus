import 'package:cached_network_image/cached_network_image.dart';
import 'package:campus/api/apisfornews/Slidermodel.dart';
import 'package:campus/api/apisfornews/all_news.dart';
import 'package:campus/api/apisfornews/articalmodel.dart';
import 'package:campus/api/apisfornews/articleview.dart';
import 'package:campus/api/apisfornews/category_news.dart';
import 'package:campus/api/apisfornews/categorymodel.dart';
import 'package:campus/api/apisfornews/data.dart';
import 'package:campus/api/apisfornews/sliderdata.dart';
import 'package:campus/api/newsapi.dart';
import 'package:campus/helper/add_screen.dart';
import 'package:campus/helper/post_widget.dart';
import 'package:campus/utils/Style/Scedule.dart';
import 'package:campus/utils/Style/SettingsPage.dart';
import 'package:campus/utils/Style/Todolists/Todocpy.dart';
import 'package:campus/utils/Style/document.dart';
import 'package:campus/utils/constants/text_strings.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:campus/utils/Style/Profile.dart';
import 'package:campus/utils/Style/Notification.dart';
import 'package:campus/api/user_controller.dart';
import 'package:campus/helper/profile_edit.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Welcomepage extends StatefulWidget {
  @override
  _WelcomepageState createState() => _WelcomepageState();
}

class _WelcomepageState extends State<Welcomepage>
    with SingleTickerProviderStateMixin {
  bool _isSearching = false;
  late AnimationController animationController;
  static const double minDragStartEdge = 60.0;
  static const double maxDragStartEdge = 0.0;
  bool canBeDragged = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
  }

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = animationController.isDismissed &&
        details.globalPosition.dx < minDragStartEdge;
    bool isDragCloseFromRight = animationController.isCompleted &&
        details.globalPosition.dx > maxDragStartEdge;
    canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (canBeDragged) {
      double delta = details.primaryDelta! / 225.0;
      animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (animationController.isDismissed || animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= 365.0) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;
      animationController.fling(velocity: visualVelocity);
    } else if (animationController.value < 0.5) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }

  void toggle() => animationController.isDismissed
      ? animationController.forward()
      : animationController.reverse();

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<
        UserController>(); // Ensure this is registered before calling Get.find

    var myDrawer = Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/backimage.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            accountName: Obx(() => Text(userController.name.value.isEmpty
                ? 'UserName@#*..'
                : userController.name.value)),
            accountEmail: Obx(() => Text(userController.email.value.isEmpty
                ? 'Loading...'
                : userController.email.value)),
            currentAccountPicture: CircleAvatar(
              child: GestureDetector(
                onTap: () {
                  Get.to(() => Profile(email: 'test@example.com'));
                },
                child: ClipOval(
                  child: Obx(() {
                    return CircleAvatar(
                      radius: 70,
                      backgroundImage: userController.imageLink.value.isNotEmpty
                          ? NetworkImage(userController.imageLink.value)
                          : AssetImage('assets/images/content/avatar.jpg')
                              as ImageProvider,
                      backgroundColor: Colors.grey[200],
                    );
                  }),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Settingspage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.list_alt_rounded),
            title: Text('To do'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TodoScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.class_),
            title: Text('Save Files'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DocumentPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help'),
            onTap: () {},
          ),
        ],
      ),
    );

    var myChild = Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF674AEF),
          elevation: 4,
          toolbarHeight: 70,
          title: _isSearching
              ? TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.white24,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  ),
                  style: TextStyle(color: Colors.white),
                )
              : Text(
                  'Welcome Probationares',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'TimesNewRoman',
                  ),
                ),
          leading: Builder(builder: (context) {
            return IconButton(
              icon: Container(
                height: 50,
                width: 100,
                child: Image.asset('assets/logos/campus-icon.png'),
              ),
              onPressed: () {
                toggle();
              },
            );
          }),
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _isSearching = !_isSearching;
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Notifacition()),
                );
              },
            ),
          ],
          shape: Border(
            bottom: BorderSide(
              color: Colors.black,
              width: 2,
            ),
          ),
        ),
        drawer: myDrawer,
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('posts').snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) => PostWidget(
                  snap: snapshot.data!.docs[index].data(),
                ),
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddScreen()),
            );
          },
          child: Icon(Icons.add),
          tooltip: 'Add Post',
        ),
      ),
    );
    return GestureDetector(
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      onTap: toggle,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, _) {
          double slide = 225.0 * animationController.value;
          double scale = 1 - (animationController.value * 0.3);
          return Stack(
            children: <Widget>[
              Transform.translate(
                offset: Offset(225.0 * animationController.value, 0),
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(-math.pi / 2 * animationController.value),
                  alignment: Alignment.centerLeft,
                  child: myChild,
                ),
              ),
              Transform.translate(
                offset: Offset(225.0 * (animationController.value - 1), 0),
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(-math.pi / 2 * (1 - animationController.value)),
                  alignment: Alignment.centerRight,
                  child: myDrawer,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
