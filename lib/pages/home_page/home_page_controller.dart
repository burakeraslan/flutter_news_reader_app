import 'package:flutter/material.dart';
import 'package:flutter_news_reader_app/pages/bookmarks_page/bookmarks_page.dart';
import 'package:flutter_news_reader_app/pages/news_page/news_page.dart';
import 'package:flutter_news_reader_app/pages/search_page/search_page.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  int currentIndex = 0;
  List<Widget> pages = [
    const NewsPage(),
    const SearchPage(),
    const BookmarksPage(),
  ];

  void changePage(int index) {
    currentIndex = index;
    update();
  }
}
