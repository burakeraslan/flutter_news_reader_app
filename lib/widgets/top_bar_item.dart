import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopBarItem extends StatelessWidget {
  final String text;
  final RxInt selectedIndex;
  final int index;
  final VoidCallback onPressed;

  const TopBarItem({
    super.key,
    required this.text,
    required this.selectedIndex,
    required this.index,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: selectedIndex.value == index ? Colors.black : Colors.white,
          ),
          child: Text(
            text,
            style: TextStyle(
              color: selectedIndex.value == index ? Colors.white : Colors.black,
            ),
          ),
        ));
  }
}
