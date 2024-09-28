import 'package:cached_network_image/cached_network_image.dart';
import 'package:campus/api/apisfornews/Slidermodel.dart';
import 'package:campus/api/apisfornews/articalmodel.dart';
import 'package:campus/api/apisfornews/articleview.dart';
import 'package:campus/api/apisfornews/sliderdata.dart';
import 'package:campus/api/newsapi.dart';
import 'package:flutter/material.dart';

class AllNews extends StatefulWidget {
  String news;
  AllNews({required this.news});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  List<Slidermodel> sliders = [];
  List<Articalmodel> articles = [];

  void initState() {
    super.initState();
    getslider();
    getNews();
  }

  getNews() async {
    News newsclass = News();
    await newsclass.getNews();
    articles = newsclass.news;
    setState(() {});
  }

  getslider() async {
    Sliders slider = Sliders();
    await slider.getSlider();
    sliders = slider.sliders;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.news + " News",
          style: TextStyle(color: Colors.blueAccent, fontSize: 24),
        ),
        centerTitle: true,
        elevation: 0.1,
      ),
      body: Container(
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount:
              widget.news == "Top Trendings" ? sliders.length : articles.length,
          itemBuilder: (context, index) {
            return AllNewsSection(
              Image: widget.news == "Top Trendings"
                  ? sliders[index].urlToImage!
                  : articles[index].urlToImage!,
              desc: widget.news == "Top Trendings"
                  ? sliders[index].description!
                  : articles[index].description!,
              title: widget.news == "Top Trendings"
                  ? sliders[index].title!
                  : articles[index].title!,
              url: widget.news == "Top Trendings"
                  ? sliders[index].url!
                  : articles[index].url!,
            );
          },
        ),
      ),
    );
  }
}

class AllNewsSection extends StatelessWidget {
  String Image, desc, title, url;
  AllNewsSection(
      {required this.Image,
      required this.desc,
      required this.title,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Articleview(blogUrl: url)));
      },
      child: Container(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: Image,
                width: MediaQuery.of(context).size.width,
                height: 250,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.error_outline,
                  size: 100,
                  color: Colors.red,
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              title,
              maxLines: 2,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              desc,
              maxLines: 3,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
