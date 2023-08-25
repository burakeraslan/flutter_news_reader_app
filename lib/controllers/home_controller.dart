import 'dart:convert';

import 'package:flutter_news_reader_app/models/news_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController {
  String apiKey = "e54811512d1c438db37939179e4f5c1f";
  String top = "https://newsapi.org/v2/top-headlines?country=us&apiKey=";
  String politics = "https://newsapi.org/v2/top-headlines?country=us&category=politics&apiKey=";
  String entertainment = "https://newsapi.org/v2/top-headlines?country=us&category=entertainment&apiKey=";
  String science = "https://newsapi.org/v2/top-headlines?country=us&category=science&apiKey=";
  String technology = "https://newsapi.org/v2/top-headlines?country=us&category=technology&apiKey=";

  final newsModel = Rx<NewsModel?>(null);
  RxInt topBarIndex = 0.obs;

  Future<void> fetchData() async {
    String api = "";

    if (topBarIndex == 0) {
      api = "$top$apiKey";
    } else if (topBarIndex == 1) {
      api = "$politics$apiKey";
    } else if (topBarIndex == 2) {
      api = "$entertainment$apiKey";
    } else if (topBarIndex == 3) {
      api = "$science$apiKey";
    } else if (topBarIndex == 4) {
      api = "$technology$apiKey";
    }

    var response = await http.get(Uri.parse(api));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      NewsModel modelData = NewsModel.fromJson(data);
      newsModel.value = modelData;
      // print(newsModel.value?.articles[0].author);
      print("çalıştım");
      print(api);
    } else {
      throw Exception("Error");
    }
  }
}
