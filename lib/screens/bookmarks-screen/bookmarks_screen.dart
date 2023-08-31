import 'package:flutter/material.dart';
import 'package:flutter_news_reader_app/models/news_model.dart';
import 'package:flutter_news_reader_app/widgets/item.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    List<dynamic> bookmarks = box.read("bookmarks") ?? [];
    List<Article> bookmarkedArticles = bookmarks.map((e) => Article.fromJson(e)).toList();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: SvgPicture.asset(
                "assets/icons/news-logo.svg",
                height: 24,
                width: 24,
              ),
            ),
            const Text(
              "News 24",
              style: TextStyle(color: Color(0xFF180E19), fontFamily: "SF-Pro-Bold", fontSize: 15),
            ),
          ],
        ),
        toolbarHeight: 75,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: bookmarkedArticles.length,
        itemBuilder: (context, index) {
          final article = bookmarkedArticles[index];
          return Item(article: article, isBookmark: "Remove Bookmark");
        },
      ),
    );
  }
}
