import 'dart:convert';

import 'package:campus/api/apisfornews/Slidermodel.dart';
import 'package:campus/api/apisfornews/articalmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Sliders {
  List<Slidermodel> sliders = [];

  Future<void> getSlider() async {
    String url =
        "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=408e7c010843457d97784bf322b20471";
    var response = await http.get(Uri.parse(url));
    print(response.body);
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          Slidermodel slidermodel = Slidermodel(
            author: element["author"],
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
          );
          sliders.add(slidermodel);
        }
      });
    }
  }
}
