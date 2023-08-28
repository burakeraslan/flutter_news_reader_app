import 'package:flutter/material.dart';
import 'package:flutter_news_reader_app/models/news_model.dart';
import 'package:flutter_news_reader_app/screens/news-screen/news_screen_controller.dart';
import 'package:flutter_news_reader_app/screens/selected-news/selected_news.dart';
import 'package:get/get.dart';

class Item extends StatelessWidget {
  Item({
    super.key,
    required this.article,
  });

  final Article? article;
  final selectedNewsController = Get.put(NewsScreenController());

  @override
  Widget build(BuildContext context) {
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
                        Text(
                          "${article?.publishedAt}",
                          style: const TextStyle(fontSize: 13, fontFamily: "SF-Pro-Medium", color: Color(0xFF909090)),
                        ),
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
