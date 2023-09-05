import 'package:flutter/material.dart';
import 'package:flutter_news_reader_app/pages/home_page/home_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(
    const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  );
}
