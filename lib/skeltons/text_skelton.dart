import 'package:flutter/material.dart';
import 'package:news_app/colors/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class TextSkelton extends StatelessWidget {
  final double width;
  const TextSkelton({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(255, 205, 205, 205),
      highlightColor: AppColors.white,
      period: const Duration(seconds: 1),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.skeltonColor,
        ),
        height: 10,
        width: width,
      ),
    );
  }
}
