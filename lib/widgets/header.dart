import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(75);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
          ),
        ],
      ),
      toolbarHeight: 75,
      elevation: 0,
      backgroundColor: Colors.white,
    );
  }
}
