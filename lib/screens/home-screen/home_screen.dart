import 'package:flutter/material.dart';
import 'package:flutter_news_reader_app/screens/home-screen/home_screen_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeScreenController = Get.put(HomeScreenController());

    void onItemTapped(int index) {
      homeScreenController.currentIndex.value = index;
    }

    return Scaffold(
      body: Obx(() => homeScreenController.screens[homeScreenController.currentIndex.value]),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: SvgPicture.asset("assets/icons/home-unselected.svg"), activeIcon: SvgPicture.asset("assets/icons/home-selected.svg"), label: "News"),
          BottomNavigationBarItem(icon: SvgPicture.asset("assets/icons/search-unselected.svg"), activeIcon: SvgPicture.asset("assets/icons/search-selected.svg"), label: "Search"),
        ],
        backgroundColor: Colors.white,
        currentIndex: homeScreenController.currentIndex.value,
        onTap: onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 24,
        selectedItemColor: const Color(0xFF180E19),
        unselectedItemColor: const Color(0xFF180E19),
        elevation: 0,
      ),
    );
  }
}
