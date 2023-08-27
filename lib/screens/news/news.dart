import 'package:flutter/material.dart';
import 'package:flutter_news_reader_app/controllers/home_controller.dart';
import 'package:flutter_news_reader_app/widgets/item.dart';
import 'package:flutter_news_reader_app/widgets/top_bar_item.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class News extends StatelessWidget {
  const News({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    Future<void> handleHomeController() async {
      await controller.fetchData();
    }

    // handleHomeController();

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
              )
            ],
          ),
          toolbarHeight: 75,
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  TopBarItem(
                    text: "Top",
                    selectedIndex: controller.topBarIndex,
                    index: 0,
                    onPressed: () {
                      controller.topBarIndex.value = 0;
                      print(controller.topBarIndex);
                      // controller.fetchData();
                    },
                  ),
                  TopBarItem(
                      text: "Politics",
                      selectedIndex: controller.topBarIndex,
                      index: 1,
                      onPressed: () {
                        controller.topBarIndex.value = 1;
                        print(controller.topBarIndex);
                        // controller.fetchData();
                      }),
                  TopBarItem(
                      text: "Entertainment",
                      selectedIndex: controller.topBarIndex,
                      index: 2,
                      onPressed: () {
                        controller.topBarIndex.value = 2;
                        print(controller.topBarIndex);
                        // controller.fetchData();
                      }),
                  TopBarItem(
                      text: "Science",
                      selectedIndex: controller.topBarIndex,
                      index: 3,
                      onPressed: () {
                        controller.topBarIndex.value = 3;
                        print(controller.topBarIndex);
                        // controller.fetchData();
                      }),
                  TopBarItem(
                      text: "Technology",
                      selectedIndex: controller.topBarIndex,
                      index: 4,
                      onPressed: () {
                        controller.topBarIndex.value = 4;
                        print(controller.topBarIndex);
                        // controller.fetchData();
                      }),
                ],
              ),
            ),
            Obx(
              () => Expanded(
                child: ListView.builder(
                  itemCount: controller.newsModel.value?.articles.length ?? 0,
                  itemBuilder: (context, index) {
                    final article = controller.newsModel.value?.articles[index];
                    return Item(article: article);
                  },
                ),
              ),
            )
          ],
        ));
  }
}
