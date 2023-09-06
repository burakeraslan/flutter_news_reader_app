import 'package:flutter/material.dart';
import 'package:flutter_news_reader_app/core/services/locale_services.dart';
import 'package:flutter_news_reader_app/pages/news_page/news_page_controller.dart';
import 'package:flutter_news_reader_app/widgets/item.dart';
import 'package:flutter_news_reader_app/widgets/top_bar_item.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(
      NewsPageController(),
    );

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: SvgPicture.asset(
                SvgIcon.newsLogo,
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
      body: const Column(
        children: [
          _TabArea(),
          _NewsArea(),
        ],
      ),
    );
  }
}

class _NewsArea extends StatelessWidget {
  const _NewsArea();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewsPageController>(
      builder: (controller) {
        return Expanded(
          child: ListView.builder(
            itemCount: controller.newsModel.value?.articles.length ?? 0,
            itemBuilder: (context, index) {
              final article = controller.newsModel.value?.articles[index];
              if (article?.url == null || article?.urlToImage == null) return const SizedBox();

              return Item(article: article);
            },
          ),
        );
      },
    );
  }
}

class _TabArea extends StatelessWidget {
  const _TabArea();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewsPageController>(
      builder: (controller) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TopBarItem(
                text: "Top",
                selectedIndex: controller.topBarIndex,
                index: 0,
              ),
              TopBarItem(
                text: "Politics",
                selectedIndex: controller.topBarIndex,
                index: 1,
              ),
              TopBarItem(
                text: "Entertainment",
                selectedIndex: controller.topBarIndex,
                index: 2,
              ),
              TopBarItem(
                text: "Science",
                selectedIndex: controller.topBarIndex,
                index: 3,
              ),
              TopBarItem(
                text: "Technology",
                selectedIndex: controller.topBarIndex,
                index: 4,
              ),
            ],
          ),
        );
      },
    );
  }
}
