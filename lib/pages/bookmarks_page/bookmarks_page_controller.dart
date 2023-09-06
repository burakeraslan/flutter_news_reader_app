import 'package:flutter_news_reader_app/models/news_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BookmarksPageController extends GetxController {
  final box = GetStorage();
  late List<dynamic> bookmarks;
  late List<Article> bookmarkedArticles;

  @override
  void onInit() {
    _init();
    super.onInit();
  }

  Future<void> _init() async {
    bookmarks = box.read("bookmarks") ?? [];
    bookmarkedArticles = bookmarks.map((e) => Article.fromJson(e)).toList();
  }
}
