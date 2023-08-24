import 'package:flutter/material.dart';
import 'package:flutter_news_reader_app/controllers/home_controller.dart';
import 'package:flutter_news_reader_app/models/news_model.dart';
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
      print(controller.newsModel.value?.articles[0].urlToImage);
      print("${controller.newsModel.value?.articles[0].title}");
    }

    // Bir kez çalıştırıp sonrasında yorum satırı haline getiriyorum...
    handleHomeController();

    RxInt topBarIndex = 0.obs;

    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: SvgPicture.asset("assets/icons/news-logo.svg", height: 24),
              ),
              const Text(
                "News 24",
                style: TextStyle(color: Color(0xFF180E19), fontFamily: "SF-Pro-Bold", fontSize: 18),
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
                    text: "sa",
                    selectedIndex: topBarIndex,
                    index: 0,
                    onPressed: () {
                      topBarIndex.value = 0;
                      print(topBarIndex.value);
                    },
                  ),
                  TopBarItem(
                      text: "as",
                      selectedIndex: topBarIndex,
                      index: 1,
                      onPressed: () {
                        topBarIndex.value = 1;
                        print(topBarIndex.value);
                      })
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: controller.newsModel.value?.articles.length ?? 0,
                itemBuilder: (context, index) {
                  final article = controller.newsModel.value?.articles[index];
                  return Item(article: article);
                },
              ),
            ),
          ],
        ));
  }
}

class Item extends StatelessWidget {
  const Item({
    super.key,
    required this.article,
  });

  final Article? article;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
                        style: const TextStyle(fontSize: 18, fontFamily: "SF-Pro-Bold", color: Color(0xFF180E19)),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "${article?.author}",
                        style: const TextStyle(fontSize: 13, fontFamily: "SF-Pro-Medium", color: Color(0xFF909090)),
                        maxLines: 1,
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
