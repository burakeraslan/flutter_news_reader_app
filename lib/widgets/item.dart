import 'package:flutter/material.dart';
import 'package:flutter_news_reader_app/models/news_model.dart';
import 'package:flutter_news_reader_app/screens/news-screen/news_screen_controller.dart';
import 'package:flutter_news_reader_app/screens/selected-news/selected_news.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Item extends StatelessWidget {
  Item({
    super.key,
    required this.article,
  });

  final Article? article;
  final selectedNewsController = Get.put(NewsScreenController());

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    List<Article>? bookmarkList = box.read<List<Article>>("bookmark");
    print("length: ${bookmarkList?.length}");

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
                if (article?.urlToImage == null || article?.urlToImage?.isEmpty == true)
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
                    "${article?.urlToImage}",
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
                          "${article?.title}",
                          style: const TextStyle(fontSize: 14, fontFamily: "SF-Pro-Bold", color: Color(0xFF180E19)),
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "${article?.author}",
                          style: const TextStyle(fontSize: 13, fontFamily: "SF-Pro-Medium", color: Color(0xFF909090)),
                          maxLines: 2,
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
                                Get.defaultDialog(backgroundColor: const Color(0xFFF6F7F5), actions: [
                                  InkWell(
                                    onTap: () {
                                      print("Share");
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
                                  InkWell(
                                    onTap: () {
                                      if (article != null) {
                                        List<Article>? bookmarkList = box.read<List<Article>>("bookmark");
                                        if (bookmarkList == null) {
                                          bookmarkList = [article!];
                                        } else {
                                          bookmarkList.add(article!);
                                        }
                                        box.write("bookmark", bookmarkList);
                                      }
                                      print(box.read("bookmark")[bookmarkList!.length - 1].title);
                                    },
                                    child: Row(
                                      children: [
                                        SvgPicture.asset("assets/icons/bookmark-unselected.svg", width: 16, height: 16),
                                        const Text(
                                          "Bookmark",
                                          style: TextStyle(
                                            fontFamily: "SF-Pro-Regular",
                                            color: Color(0xFF180E19),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ]);
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
}
