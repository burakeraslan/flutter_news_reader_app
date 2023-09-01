import 'package:flutter/material.dart';
import 'package:flutter_news_reader_app/models/news_model.dart';
import 'package:flutter_news_reader_app/widgets/header.dart';
import 'package:flutter_news_reader_app/widgets/item.dart';
import 'package:get_storage/get_storage.dart';

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    List<dynamic> bookmarks = box.read("bookmarks") ?? [];
    List<Article> bookmarkedArticles = bookmarks.map((e) => Article.fromJson(e)).toList();

    return Scaffold(
      appBar: const Header(),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: bookmarkedArticles.length,
        itemBuilder: (context, index) {
          final article = bookmarkedArticles[index];
          if (article.urlToImage == null || article.urlToImage!.isEmpty) return const SizedBox();
          return Item(article: article);
        },
      ),
    );
  }
}
