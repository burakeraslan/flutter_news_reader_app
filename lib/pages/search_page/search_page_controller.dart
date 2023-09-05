import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_news_reader_app/models/news_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SearchPageController extends GetxController {
  RxString input = "".obs;
  String apiKey = "e54811512d1c438db37939179e4f5c1f";

  final newsModel = Rx<NewsModel?>(null);

  Future<void> fetchData() async {
    String baseUrl = "https://newsapi.org/v2/top-headlines?q=${input.value}&apiKey=";
    String api = baseUrl + apiKey;

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
