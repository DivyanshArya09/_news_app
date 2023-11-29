import 'package:flutter/material.dart';
import 'package:news_app/colors/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class SkeltonContainer extends StatelessWidget {
  final double height, width, borderRadius;
  const SkeltonContainer(
      {super.key,
      required this.height,
      required this.width,
      required this.borderRadius});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color:
              AppColors.lightgrey, // Replace with your desired container color
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(children: [
          Shimmer.fromColors(
            baseColor: AppColors.grey,
            highlightColor: AppColors.white,
            child: Container(
              height: size.height * .3,
              width: size.width,
              color: AppColors.grey,
            ),
          ),
          const SizedBox(
            height: 13,
          ),
        ]),
      ),
    );
  }
}
