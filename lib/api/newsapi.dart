import 'dart:convert';

import 'package:campus/api/apisfornews/articalmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class News {
  List<Articalmodel> news = [];

  Future<void> getNews() async {
    String url =
        "https://newsapi.org/v2/everything?q=apple&from=2024-09-09&to=2024-09-09&sortBy=popularity&apiKey=408e7c010843457d97784bf322b20471";
    var response = await http.get(Uri.parse(url));
    print(response.body);
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          Articalmodel articalmodel = Articalmodel(
            author: element["author"],
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
          );
          news.add(articalmodel);
        }
      });
    }
  }
}
