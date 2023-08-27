import 'package:flutter/material.dart';
import 'package:flutter_news_reader_app/controllers/search_screen_controller.dart';
import 'package:get/get.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = Get.put(SearchScreenController());

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 75,
            color: Colors.white,
            width: double.maxFinite,
            padding: const EdgeInsets.all(15),
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: "Search",
                hintStyle: TextStyle(color: Color(0xFF909090), fontSize: 15),
                filled: true,
                fillColor: Color(0xFFEEEEEE),
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(40)), borderSide: BorderSide.none),
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                prefixIcon: Icon(Icons.search),
                prefixIconColor: Color(0xFF909090),
                // suffixIcon: IconButton(
                //     onPressed: () {
                //       searchController.input.value = "";
                //       print(searchController.input.value);
                //       TextEditingController().clear();
                //     },
                //     icon: const Icon(Icons.clear)),
                // suffixIconColor: const Color(0xFF909090)
              ),
              onFieldSubmitted: (value) {
                searchController.input.value = value;
                print(searchController.input.value);
              },
            ),
          )
        ],
      ),
    );
  }
}
