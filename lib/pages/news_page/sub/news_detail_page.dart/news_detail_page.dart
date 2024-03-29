import 'package:flutter/material.dart';
import 'package:flutter_news_reader_app/core/services/locale_services.dart';
import 'package:flutter_news_reader_app/models/news_model.dart';
import 'package:flutter_news_reader_app/pages/news_page/news_page_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailPage extends StatelessWidget {
  const NewsDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedNewsController = Get.put(
      NewsPageController(),
    );

    final box = GetStorage();
    List<dynamic> bookmarks = box.read("bookmarks") ?? [];
    String bookmarked = bookmarks.indexWhere((bookmark) => Article.fromJson(bookmark).url == selectedNewsController.selectedArticle.value?.url) != -1
        ? SvgIcon.bookmarkSelected
        : SvgIcon.bookmarkUnselected;

    Future addAndDeleteBookmark() async {
      if (bookmarks.indexWhere((bookmark) => Article.fromJson(bookmark).url == selectedNewsController.selectedArticle.value?.url) != -1) {
        int indexToDelete = bookmarks.indexWhere((bookmark) => Article.fromJson(bookmark).url == selectedNewsController.selectedArticle.value?.url);

        if (indexToDelete != -1) {
          bookmarks.removeAt(indexToDelete);
          await box.write("bookmarks", bookmarks);
          Get.forceAppUpdate();
        }
      } else {
        bookmarks.add(selectedNewsController.selectedArticle.value?.toJson());
        await box.write("bookmarks", bookmarks);
        Get.forceAppUpdate();
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(
            SvgIcon.chevronLeft,
            height: 24,
            width: 24,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
              onPressed: () => addAndDeleteBookmark(),
              icon: SvgPicture.asset(
                bookmarked,
                height: 24,
                width: 24,
              )),
          IconButton(
              onPressed: () {
                Share.share("${selectedNewsController.selectedArticle.value?.url}");
              },
              icon: SvgPicture.asset(
                SvgIcon.share,
                height: 24,
                width: 24,
              ))
        ],
        toolbarHeight: 75,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              "${selectedNewsController.selectedArticle.value?.urlToImage}",
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text("${selectedNewsController.selectedArticle.value?.title}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: "SF-Pro-Bold",
                        color: Color(0xFF180E19),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            "${selectedNewsController.selectedArticle.value?.author}",
                            style: const TextStyle(
                              fontSize: 13,
                              fontFamily: "SF-Pro-Medium",
                              color: Color(0xFF909090),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "${selectedNewsController.selectedArticle.value?.publishedAt}",
                            style: const TextStyle(
                              fontSize: 13,
                              fontFamily: "SF-Pro-Medium",
                              color: Color(0xFF909090),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text("${selectedNewsController.selectedArticle.value?.content}",
                        style: const TextStyle(
                          fontSize: 15,
                          fontFamily: "SF-Pro-Regular",
                          color: Color(0xFF180E19),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF180E19)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        elevation: MaterialStateProperty.all<double>(0),
                      ),
                      onPressed: () {
                        final articleUrl = selectedNewsController.selectedArticle.value?.url;
                        if (articleUrl != null) {
                          launch(articleUrl);
                        }
                      },
                      child: const Text(
                        "Read more",
                        style: TextStyle(fontSize: 15, fontFamily: "SF-Pro-Medium", color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
