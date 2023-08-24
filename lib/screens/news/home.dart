import 'package:flutter/material.dart';
import 'package:flutter_news_reader_app/screens/news/news.dart';
import 'package:flutter_news_reader_app/screens/search/search.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Widget> _screens = [const News(), const Search()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: SvgPicture.asset("assets/icons/home-unselected.svg"), activeIcon: SvgPicture.asset("assets/icons/home-selected.svg"), label: "News"),
            BottomNavigationBarItem(icon: SvgPicture.asset("assets/icons/search-unselected.svg"), activeIcon: SvgPicture.asset("assets/icons/search-selected.svg"), label: "Search"),
          ],
          backgroundColor: Colors.white,
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          iconSize: 24,
          selectedItemColor: const Color(0xFF180E19),
          unselectedItemColor: const Color(0xFF180E19),
          elevation: 0,
        ));
  }
}
