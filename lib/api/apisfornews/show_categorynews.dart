import 'dart:convert';
import 'package:campus/api/apisfornews/Slidermodel.dart';
import 'package:campus/api/apisfornews/articalmodel.dart';
import 'package:campus/api/apisfornews/category_model.dart';
import 'package:campus/api/apisfornews/categorymodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ShowCategorynews {
  List<ShowCategorymodel> categories = [];

  Future<void> getCategoriesNews(String category) async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=408e7c010843457d97784bf322b20471";
    var response = await http.get(Uri.parse(url));
    print(response.body);
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ShowCategorymodel CategoryModel = ShowCategorymodel(
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
            author: element["author"],
          );
          categories.add(CategoryModel);
        }
      });
    }
  }
}
