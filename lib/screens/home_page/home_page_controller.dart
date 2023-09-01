import 'package:flutter/material.dart';
import 'package:flutter_news_reader_app/screens/bookmarks-screen/bookmarks_screen.dart';
import 'package:flutter_news_reader_app/screens/news_page/news_page.dart';
import 'package:flutter_news_reader_app/screens/search-screen/search_screen.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  int currentIndex = 0;
  List<Widget> pages = [
    const NewsPage(),
    const SearchScreen(),
    const BookmarksScreen(),
  ];

  void changePage(int index) {
    currentIndex = index;

    update();
  }
}
