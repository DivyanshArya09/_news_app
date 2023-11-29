import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

class SearchNews extends StatelessWidget {
  final VoidCallback onTap;
  final TextEditingController searchController;
  const SearchNews(
      {super.key, required this.onTap, required this.searchController});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          width: size.width * .9,
          height: 50,
          child: TextField(
            controller: searchController,
            decoration: const InputDecoration(
              fillColor: AppColors.lightgrey,
              filled: true,
              hintText: 'Search',
              hintStyle: TextStyle(color: AppColors.grey),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              prefixIcon: Icon(Icons.search, color: AppColors.grey),
            ),
          ),
        ),
      ],
    );
  }
}
