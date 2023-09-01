import 'package:flutter/material.dart';
import 'package:flutter_news_reader_app/models/news_model.dart';
import 'package:flutter_news_reader_app/screens/news_page/news_page_controller.dart';
import 'package:flutter_news_reader_app/screens/news_page/sub/news_detail_page.dart/news_detail_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    List<dynamic> bookmarks = box.read("bookmarks") ?? [];
    List<Article> bookmarkedArticles = bookmarks.map((e) => Article.fromJson(e)).toList();

    final selectedNewsController = Get.put(
      NewsPageController(),
    );

    Future deleteBookmark(Article articleToDelete) async {
      int indexToDelete = bookmarks.indexWhere((bookmark) => Article.fromJson(bookmark).url == articleToDelete.url);
      if (indexToDelete != -1) {
        bookmarks.removeAt(indexToDelete);
        await box.write("bookmarks", bookmarks);
        bookmarkedArticles = bookmarks.map((e) => Article.fromJson(e)).toList();
        Get.forceAppUpdate();
      }
    }

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
          if (article.urlToImage == null || article.urlToImage!.isEmpty) return const SizedBox();
          return Column(
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => const SelectedNews());
                  selectedNewsController.selectedArticle.value = article;
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  height: 180,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (article.urlToImage == null || article.urlToImage?.isEmpty == true)
                        Container(
                          width: 140,
                          height: 140,
                          color: const Color(0xFF909090),
                          alignment: Alignment.center,
                          child: const Text(
                            "No Image",
                            style: TextStyle(fontSize: 18, color: Colors.white, fontFamily: "SF-Pro-Bold"),
                          ),
                        )
                      else
                        Image.network(
                          "${article.urlToImage}",
                          width: 140,
                          height: 140,
                          fit: BoxFit.cover,
                        ),
                      Flexible(
                        child: Container(
                          margin: const EdgeInsetsDirectional.only(start: 10),
                          height: 140,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${article.title}",
                                style: const TextStyle(fontSize: 14, fontFamily: "SF-Pro-Bold", color: Color(0xFF180E19)),
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "${article.author}",
                                style: const TextStyle(fontSize: 13, fontFamily: "SF-Pro-Medium", color: Color(0xFF909090)),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${article.publishedAt}",
                                    style: const TextStyle(fontSize: 13, fontFamily: "SF-Pro-Medium", color: Color(0xFF909090)),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      getDialog(deleteBookmark, article);
                                    },
                                    icon: SvgPicture.asset("assets/icons/menu.svg", height: 24, width: 24),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Divider(
                  color: Color(0xFFEEEEEE),
                  thickness: 1,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

Future<dynamic> getDialog(Future<dynamic> Function(Article articleToDelete) deleteBookmark, Article article) {
  return Get.defaultDialog(
    backgroundColor: const Color(0xFFF6F7F5),
    title: "",
    content: Column(
      children: [
        InkWell(
          onTap: () {
            // share
            Get.back();
          },
          child: Row(
            children: [
              SvgPicture.asset("assets/icons/share.svg", width: 16, height: 16),
              const Text(
                "Share",
                style: TextStyle(
                  fontFamily: "SF-Pro-Regular",
                  color: Color(0xFF180E19),
                ),
              )
            ],
          ),
        ),
        const Divider(
          color: Color(0xFFEEEEEE),
          thickness: 1,
        ),
        InkWell(
          onTap: () {
            deleteBookmark(article);
            Get.back();
          },
          child: Row(
            children: [
              SvgPicture.asset("assets/icons/bookmark-selected.svg", width: 16, height: 16),
              const Text(
                "Remove Bookmark",
                style: TextStyle(
                  fontFamily: "SF-Pro-Regular",
                  color: Color(0xFF180E19),
                ),
              )
            ],
          ),
        ),
      ],
    ).paddingOnly(top: 0, left: 20, right: 20, bottom: 10),
  );
}
