import 'package:campus/utils/Style/Scedule.dart';
import 'package:campus/utils/Style/SettingsPage.dart';
import 'package:campus/utils/Style/Todolists/Todocpy.dart';
import 'package:flutter/material.dart';
import 'package:campus/utils/Style/Profile.dart';
import 'package:campus/utils/Style/Notification.dart';
import 'package:campus/utils/Style/Notification.dart';
import 'dart:math' as math;

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
    var myDrawer = Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://tz-mag-media.s3.ap-southeast-1.amazonaws.com/wp-content/uploads/2018/11/08110153/image25.png'),
                fit: BoxFit.cover,
              ),
            ),
            accountName: Text("AdelKing047#"),
            accountEmail: Text("adelzahid01@gmail.com"),
            currentAccountPicture: CircleAvatar(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Profile(
                              email: '',
                            )),
                  );
                },
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/content/avatar.jpg',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
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
            onTap: () {
              Navigator.pop(context);
            },
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
            title: Text('Schedule'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SchedulePage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Work-List'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );

    var myChild = Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF674AEF),
          elevation: 4, // Add elevation for a shadow effect
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
            ), // Adjust width and color as needed
          ),
        ),
        drawer: myDrawer,
        body: Container(
          color: Colors.white54,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    print('Tapped on Container');
                                  },
                                  onDoubleTap: () {
                                    print('Double tap');
                                  },
                                  onLongPress: () {
                                    print('Long Pressed on Container');
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    height: 200,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.lightGreenAccent,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "You have add pages: ",
                                        style: TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    print('Tapped on Container');
                                  },
                                  onDoubleTap: () {
                                    print('Double tap');
                                  },
                                  onLongPress: () {
                                    print('Long Pressed on Container');
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    height: 200,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.deepOrange,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Click here",
                                        style: TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    print('Tapped on Container');
                                  },
                                  onDoubleTap: () {
                                    print('Double tap');
                                  },
                                  onLongPress: () {
                                    print('Long Pressed on Container');
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    height: 200,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.amberAccent,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Click here",
                                        style: TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    print('Tapped on Container');
                                  },
                                  onDoubleTap: () {
                                    print('Double tap');
                                  },
                                  onLongPress: () {
                                    print('Long Pressed on Container');
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    height: 200,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.deepPurple,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Click here",
                                        style: TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    print('Tapped on Container');
                                  },
                                  onDoubleTap: () {
                                    print('Double tap');
                                  },
                                  onLongPress: () {
                                    print('Long Pressed on Container');
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    height: 200,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.deepOrange,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Click here",
                                        style: TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    print('Tapped on Container');
                                  },
                                  onDoubleTap: () {
                                    print('Double tap');
                                  },
                                  onLongPress: () {
                                    print('Long Pressed on Container');
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    height: 200,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.lightBlue,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Click here",
                                        style: TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // advertisement containers
                      Center(
                        child: InkWell(
                          onTap: () {
                            print('Tapped on Container');
                          },
                          onDoubleTap: () {
                            print('Double tap');
                          },
                          onLongPress: () {
                            print('Long Pressed on Container');
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10),
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(width: 5, color: Colors.black),
                            ),
                            child: Center(
                              child: Text(
                                "Click here",
                                style: TextStyle(
                                    fontSize: 21, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            print('Tapped on Container');
                          },
                          onDoubleTap: () {
                            print('Double tap');
                          },
                          onLongPress: () {
                            print('Long Pressed on Container');
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10),
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(width: 5, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            print('Tapped on Container');
                          },
                          onDoubleTap: () {
                            print('Double tap');
                          },
                          onLongPress: () {
                            print('Long Pressed on Container');
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10),
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(width: 5, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            print('Tapped on Container');
                          },
                          onDoubleTap: () {
                            print('Double tap');
                          },
                          onLongPress: () {
                            print('Long Pressed on Container');
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10),
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.lightBlue[800],
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(width: 5, color: Colors.black),
                            ),
                            child: Center(
                              child: Text(
                                "Click here",
                                style: TextStyle(
                                    fontSize: 21, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            print('Tapped on Container');
                          },
                          onDoubleTap: () {
                            print('Double tap');
                          },
                          onLongPress: () {
                            print('Long Pressed on Container');
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10),
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.cyan,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(width: 5, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
        builder: (context, child) {
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

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
