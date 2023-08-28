import 'package:flutter/material.dart';
import 'package:flutter_news_reader_app/screens/news-screen/news_screen.dart';
import 'package:flutter_news_reader_app/screens/search-screen/search_screen.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxList<Widget> screens = [const NewsScreen(), const SearchScreen()].obs;
}
