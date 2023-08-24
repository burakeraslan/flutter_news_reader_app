import 'dart:convert';

import 'package:flutter_news_reader_app/models/news_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController {
  String apiKey = "e54811512d1c438db37939179e4f5c1f";
  String url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=";
  final newsModel = Rx<NewsModel?>(null);

  Future<void> fetchData() async {
    String api = "$url$apiKey";
    var response = await http.get(Uri.parse(api));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      NewsModel modelData = NewsModel.fromJson(data);
      newsModel.value = modelData;
      // print(newsModel.value?.articles[0].author);
      print("çalıştım");
    } else {
      throw Exception("Error");
    }
  }
}
