import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Notifacition extends StatelessWidget {
  Widget build(BuildContext context) {
    theme:
    ThemeData(
      primaryColor: Colors.lightBlue,
      scaffoldBackgroundColor: Colors.white,
    );
    var arrNames = [
      'Google',
      'FaceBook',
      'Whats-App',
      'Teligram',
      'Viber',
      'Imo',
      'Gmail',
      'Campus',
      'You-Tube'
    ];
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(text: 'All'),
                  Tab(text: 'Important'),
                  Tab(text: 'Earlier'),
                  Tab(text: 'Previous'),
                ],
              ),
              elevation: 0,
              foregroundColor: Colors.black,
              backgroundColor: Colors.grey[100],
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz),
                )
              ],
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: const Text('Notifications'),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search",
                      contentPadding: const EdgeInsets.all(16.0),
                      fillColor: Colors.black12,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return Slidable(
                            endActionPane: ActionPane(
                              extentRatio: 0.3,
                              motion: ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {},
                                  icon: Icons.replay,
                                  backgroundColor: Colors.grey[300]!,
                                ),
                                SlidableAction(
                                  onPressed: (context) {},
                                  icon: Icons.delete,
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.red[700]!,
                                )
                              ],
                            ),
                            child: ListTile(
                              isThreeLine: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.089),
                              leading: const CircleAvatar(
                                radius: 25,
                                child: Icon(Icons.notifications),
                              ),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    "Google",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "2h ago",
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                              subtitle: const Text(
                                "Hello How are you .What the fuck are you doing and why the hell are you not Studing,Oi shala boke hat rekhey boll Syllabus sesh hoise.Oi khankirpola Moblie Rakh",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => Divider(
                              color: Colors.grey[400],
                              indent: size.width * 0.08,
                              endIndent: size.width * 0.08,
                            ),
                        itemCount: 10)),
              ],
            )),
      ),
    );
  }
}
