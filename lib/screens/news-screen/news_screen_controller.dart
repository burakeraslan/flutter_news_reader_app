import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_news_reader_app/models/news_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NewsScreenController extends GetxController {
  String apiKey = "e54811512d1c438db37939179e4f5c1f";
  List<String> categories = [
    "top-headlines?country=us",
    "top-headlines?country=us&category=politics",
    "top-headlines?country=us&category=entertainment",
    "top-headlines?country=us&category=science",
    "top-headlines?country=us&category=technology",
  ];

  final newsModel = Rx<NewsModel?>(null);
  RxInt topBarIndex = 0.obs;
  final selectedArticle = Rxn<Article>();

  Future<void> fetchData() async {
    String category = categories[topBarIndex.value];
    String api = "https://newsapi.org/v2/$category&apiKey=$apiKey";
    var response = await http.get(Uri.parse(api));

    try {
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        NewsModel modelData = NewsModel.fromJson(data);
        newsModel.value = modelData;
      } else {
        debugPrint("API error: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Exception: $e");
    }
  }
}
