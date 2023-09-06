import 'package:flutter/material.dart';
import 'package:flutter_news_reader_app/pages/bookmarks_page/bookmarks_page_controller.dart';
import 'package:flutter_news_reader_app/widgets/header.dart';
import 'package:flutter_news_reader_app/widgets/item.dart';
import 'package:get/get.dart';

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(
      BookmarksPageController(),
    );
    return Scaffold(
      appBar: const Header(),
      backgroundColor: Colors.white,
      body: GetBuilder<BookmarksPageController>(
        builder: (_) {
          // return Column(
          //   children: [
          //     for (int i = 0; i < _.bookmarkedArticles.length; i++) ...[
          //       Item(
          //         article: _.bookmarkedArticles[i],
          //       ),
          //     ]
          //   ],
          // );
          return ListView.builder(
            itemCount: _.bookmarkedArticles.length,
            itemBuilder: (context, index) {
              return Item(
                article: _.bookmarkedArticles[index],
              );
            },
          );
        },
      ),
    );
  }
}
