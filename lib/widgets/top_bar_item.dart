import 'package:flutter/material.dart';
import 'package:flutter_news_reader_app/screens/news_page/news_page_controller.dart';
import 'package:get/get.dart';

class TopBarItem extends StatelessWidget {
  final String text;
  final RxInt selectedIndex;
  final int index;

  const TopBarItem({
    super.key,
    required this.text,
    required this.selectedIndex,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ElevatedButton(
        onPressed: () {
          final controller = Get.find<NewsPageController>();
          controller.changeTab(index);
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: selectedIndex.value == index ? const Color(0xFF180E19) : const Color(0xFFEEEEEE),
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
        child: Text(
          text,
          style: TextStyle(
            color: selectedIndex.value == index ? Colors.white : const Color(0xFF909090),
          ),
        ),
      ),
    );
  }
}
