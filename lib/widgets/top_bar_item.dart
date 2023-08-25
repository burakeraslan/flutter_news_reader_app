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
    return Obx(() => Padding(
          padding: const EdgeInsets.only(left: 15),
          child: ElevatedButton(
            onPressed: onPressed,
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
        ));
  }
}
