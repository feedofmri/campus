import 'package:flutter/material.dart';

class Institutions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var arrColor = [
      Colors.orange,
      Colors.green,
      Colors.redAccent,
      Colors.cyanAccent,
      Colors.deepPurple,
      Colors.blue,
      Colors.pink,
      Colors.yellow,
      Colors.greenAccent,
      Colors.grey,
      Colors.amberAccent,
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.lightBlue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Scaffold(
        body: ListView(
          children: [
            Container(
              padding:
                  EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
              decoration: BoxDecoration(
                color: Colors.cyanAccent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 3, bottom: 15),
                    child: Text(
                      "Find Your Favourit Institution",
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
                    margin: EdgeInsets.only(top: 5, bottom: 20),
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
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              height: 600, // You can adjust the height as needed
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: arrColor.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  // here are the institutions logo will be sat

                  return Container(
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      //here you need to inser the image arr from server
                      color: arrColor[index],
                      borderRadius: BorderRadius.circular(20),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
