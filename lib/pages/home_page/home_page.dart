import 'package:flutter/material.dart';
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
                icon: SvgPicture.asset("assets/icons/home-unselected.svg"),
                activeIcon: SvgPicture.asset("assets/icons/home-selected.svg"),
                label: "News",
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/icons/search-unselected.svg"),
                activeIcon: SvgPicture.asset("assets/icons/search-selected.svg"),
                label: "Search",
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/icons/bookmark-unselected.svg"),
                activeIcon: SvgPicture.asset("assets/icons/bookmark-selected.svg"),
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
