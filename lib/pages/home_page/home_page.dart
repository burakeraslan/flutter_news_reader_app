import 'package:flutter/material.dart';
import 'package:flutter_news_reader_app/core/services/locale_services.dart';
import 'package:flutter_news_reader_app/pages/home_page/home_page_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(
      HomePageController(),
    );

    return GetBuilder<HomePageController>(
      builder: (homeController) {
        return Scaffold(
          body: homeController.pages[homeController.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(SvgIcon.homeUnselected),
                activeIcon: SvgPicture.asset(SvgIcon.homeSelected),
                label: "News",
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(SvgIcon.searchUnselected),
                activeIcon: SvgPicture.asset(SvgIcon.searchSelected),
                label: "Search",
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(SvgIcon.bookmarkUnselected),
                activeIcon: SvgPicture.asset(SvgIcon.bookmarkSelected),
                label: "Bookmarks",
              ),
            ],
            backgroundColor: Colors.white,
            currentIndex: homeController.currentIndex,
            onTap: (int index) {
              homeController.changePage(index);
            },
            showSelectedLabels: false,
            showUnselectedLabels: false,
            iconSize: 24,
            selectedItemColor: const Color(0xFF180E19),
            unselectedItemColor: const Color(0xFF180E19),
            elevation: 0,
          ),
        );
      },
    );
  }
}
