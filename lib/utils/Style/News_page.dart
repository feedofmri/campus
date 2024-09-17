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
import 'package:campus/utils/Style/Scedule.dart';
import 'package:campus/utils/Style/SettingsPage.dart';
import 'package:campus/utils/Style/Todolists/Todocpy.dart';
import 'package:campus/utils/Style/welcome.dart';
import 'package:campus/utils/constants/text_strings.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Newspage extends StatefulWidget {
  @override
  _NewspageState createState() => _NewspageState();
}

class _NewspageState extends State<Newspage>
    with SingleTickerProviderStateMixin {
  List<CategoryModel> categories = [];
  List<Slidermodel> sliders = [];
  List<Articalmodel> articles = [];
  int activeIndex = 0;
  bool _loading = true;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    getSlider();
    getNews();
    categories = getCategories();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    setState(() {
      articles = newsClass.news;
      _loading = false;

      // Debugging: Print the number of articles and their titles
      print('Number of articles: ${articles.length}');
      articles.forEach((article) => print(article.title));
    });
  }

  getSlider() async {
    Sliders slider = Sliders();
    await slider.getSlider();
    setState(() {
      sliders = slider.sliders;
      _loading = false;

      // Debugging: Print the number of sliders and their titles
      print('Number of sliders: ${sliders.length}');
      sliders.forEach((slider) => print(slider.title));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        elevation: 4, // Add elevation for a shadow effect
        toolbarHeight: 70,
        title: Center(child: Text("Todays News")),
        shape: Border(
          bottom: BorderSide(
            color: Colors.black,
            width: 2,
          ), // Adjust width and color as needed
        ),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator()) // Add Center widget here
          : Container(
              color: Colors.white54,
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15, bottom: 5),
                    child: Container(
                      height: 40,
                      child: Text("Categories",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'TimesNewRoman',
                            color: Colors.black,
                          )),
                    ),
                  ),
                  categories.length == 0
                      ? Center(child: Text("Error"))
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              Container(
                                height: 200,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: categories.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0.0),
                                        child: CategoryTile(
                                          image: categories[index].image,
                                          CategoryName:
                                              categories[index].categoryName,
                                        ));
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Top Trendings",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'TimesNewRoman',
                              color: Colors.black,
                            )),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AllNews(news: "Top Trendings")));
                          },
                          child: Text("View All",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'TimesNewRoman',
                                color: Colors.blue,
                              )),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            child: CarouselSlider.builder(
                              itemCount: sliders.length,
                              itemBuilder: (context, index, realIndex) {
                                String? res = sliders[index].urlToImage;
                                String? res1 = sliders[index].title;
                                return buildImage(res!, index, res1!);
                              },
                              options: CarouselOptions(
                                  height: 350,
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                  enlargeStrategy:
                                      CenterPageEnlargeStrategy.height,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      activeIndex = index;
                                    });
                                  }),
                            ),
                          ),
                          SizedBox(height: 30),
                          buildIndicator(),
                          SizedBox(height: 20),
                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("News",
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'TimesNewRoman',
                                      color: Colors.black,
                                    )),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AllNews(news: "News")));
                                  },
                                  child: Text("View All",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'TimesNewRoman',
                                        color: Colors.blue,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: articles.isEmpty
                                ? Center(child: Text("No articles available"))
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics: ClampingScrollPhysics(),
                                    itemCount: articles.length,
                                    itemBuilder: (context, index) {
                                      return BlogTile(
                                          url: articles[index].url!,
                                          desc: articles[index].description ??
                                              'No description',
                                          imageUrl: articles[index].urlToImage!,
                                          title: articles[index].title ??
                                              'No title');
                                    },
                                  ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget buildImage(String image, int index, String name) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              height: 300,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              imageUrl: image,
              errorWidget: (context, error, stackTrace) {
                return Icon(Icons.error);
              },
            ),
          ),
          Container(
            height: 130,
            padding: EdgeInsets.only(left: 10),
            margin: EdgeInsets.only(top: 200.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(10))),
            child: Text(
              name,
              maxLines: 3,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 20,
                shadows: [
                  Shadow(
                    blurRadius: 5,
                    color: Colors.black,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              textAlign: TextAlign.left,
            ),
          )
        ],
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: sliders.length,
        effect: SlideEffect(
          dotHeight: 15,
          dotWidth: 15,
          dotColor: Colors.black12,
          activeDotColor: Colors.blue,
        ),
      );
}

class CategoryTile extends StatelessWidget {
  final image, CategoryName;

  CategoryTile({required this.CategoryName, required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNews(name: CategoryName)));
      },
      child: Container(
        margin: EdgeInsets.only(right: 20),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                width: 170,
                height: 200,
              ),
            ),
            Container(
              width: 170,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black26.withOpacity(0.5), // Darken the overlay
              ),
              child: Center(
                child: Text(
                  CategoryName,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold, // Makes the text bold
                    fontStyle: FontStyle.italic, // Makes the text italic
                    fontSize: 20,
                    shadows: [
                      Shadow(
                        blurRadius: 5,
                        color: Colors.black,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  String imageUrl, title, desc, url;
  BlogTile(
      {required this.desc,
      required this.imageUrl,
      required this.title,
      required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Articleview(blogUrl: url)),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Material(
            elevation: 3.0,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                        errorWidget: (context, error, stackTrace) {
                          return Icon(Icons
                              .error); // Fallback widget if the image can't be loaded
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 1.7,
                          child: Text(
                            title,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Pacifico',
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 7.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.7,
                          child: Text(
                            desc,
                            maxLines: 3,
                            style: TextStyle(
                              fontSize: 13, // Adjusted for readability
                              fontWeight: FontWeight.w500,
                              fontFamily: 'TimesNewRoman',
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
