import 'package:flutter/material.dart';
import 'package:flutter_news_reader_app/models/news_model.dart';
import 'package:flutter_news_reader_app/screens/news_page/news_page_controller.dart';
import 'package:flutter_news_reader_app/screens/news_page/sub/news_detail_page.dart/news_detail_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Item extends StatelessWidget {
  Item({
    super.key,
    required this.article,
  });

  final Article? article;
  final selectedNewsController = Get.put(
    NewsPageController(),
  );

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    List<dynamic> bookmarks = box.read("bookmarks") ?? [];

    // dynamik bookmark icon
    String icon =
        bookmarks.indexWhere((bookmark) => Article.fromJson(bookmark).url == article!.url) != -1 ? "assets/icons/bookmark-selected.svg" : "assets/icons/bookmark-unselected.svg";

    // dynamik bookmark text
    String bookmarked = bookmarks.indexWhere((bookmark) => Article.fromJson(bookmark).url == article!.url) != -1 ? "Remove Bookmark" : "Bookmark";

    // add and delete bookmark, and update app
    Future addAndDeleteBookmark() async {
      if (bookmarks.indexWhere((bookmark) => Article.fromJson(bookmark).url == article!.url) != -1) {
        // find index of bookmark
        int indexToDelete = bookmarks.indexWhere((bookmark) => Article.fromJson(bookmark).url == article!.url);

        if (indexToDelete != -1) {
          // delete bookmark
          bookmarks.removeAt(indexToDelete);
          await box.write("bookmarks", bookmarks);
          Get.forceAppUpdate();
        }
      } else {
        // add bookmark
        bookmarks.add(article!.toJson());
        await box.write("bookmarks", bookmarks);
        Get.forceAppUpdate();
      }
    }

    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.to(() => const NewsDetailPage());
            selectedNewsController.selectedArticle.value = article;
          },
          child: Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
            height: 180,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  "${article?.urlToImage}",
                  width: 140,
                  height: 140,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      width: 140,
                      height: 140,
                      color: const Color(0xFF909090),
                      alignment: Alignment.center,
                      child: const CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  },
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
                          "${article?.title}",
                          style: const TextStyle(fontSize: 14, fontFamily: "SF-Pro-Bold", color: Color(0xFF180E19)),
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "${article?.author}",
                          style: const TextStyle(fontSize: 13, fontFamily: "SF-Pro-Medium", color: Color(0xFF909090)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${article?.publishedAt}",
                              style: const TextStyle(fontSize: 13, fontFamily: "SF-Pro-Medium", color: Color(0xFF909090)),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            IconButton(
                              onPressed: () {
                                getDialog(addAndDeleteBookmark, icon, bookmarked);
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
  }

  Future<dynamic> getDialog(Future<dynamic> Function() addAndDeleteBookmark, String icon, String bookmarked) {
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
              addAndDeleteBookmark();
              Get.back();
            },
            child: Row(
              children: [
                SvgPicture.asset(icon, width: 16, height: 16),
                Text(
                  bookmarked,
                  style: const TextStyle(
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
}
