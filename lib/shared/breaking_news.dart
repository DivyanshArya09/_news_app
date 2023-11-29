import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

class BreakingNews extends StatelessWidget {
  final VoidCallback onTapOnViewAll;
  final String title;
  const BreakingNews(
      {super.key, required this.onTapOnViewAll, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.black,
            fontSize: 20,
          ),
        ),
        TextButton(
          onPressed: onTapOnViewAll,
          child: const Text(
            'View all',
            style: TextStyle(color: AppColors.primary),
          ),
        ),
      ]),
    );
  }
}
