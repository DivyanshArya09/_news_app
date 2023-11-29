import 'package:flutter/material.dart';
import 'package:news_app/colors/app_colors.dart';

class CategoryContainer extends StatelessWidget {
  final String category;
  final bool isPressed;
  final VoidCallback onTap;
  const CategoryContainer(
      {super.key,
      required this.category,
      required this.onTap,
      required this.isPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          height: 23,
          decoration: BoxDecoration(
            color: isPressed ? AppColors.primary : AppColors.lightgrey,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Text(
              category,
              style: TextStyle(
                  color: isPressed ? AppColors.white : AppColors.black),
            ),
          ),
        ),
      ),
    );
  }
}
