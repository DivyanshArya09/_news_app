import 'package:flutter/material.dart';
import 'package:news_app/skeltons/text_skelton.dart';
import 'package:shimmer/shimmer.dart';

import '../colors/app_colors.dart';

class SkeltonNewsContainer extends StatelessWidget {
  const SkeltonNewsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    double height = 10;
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color:
              AppColors.lightgrey, // Replace with your desired container color
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: Color.fromARGB(255, 181, 181, 182),
                highlightColor: AppColors.white,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.grey,
                  ),
                  height: size.height * .3,
                  width: size.width,
                ),
              ),
              const SizedBox(
                height: 13,
              ),
              TextSkelton(width: size.width / 1),
              SizedBox(
                height: height,
              ),
              TextSkelton(width: size.width / 1.1),
              SizedBox(
                height: height,
              ),
              TextSkelton(width: size.width / 1.1),
              SizedBox(
                height: height,
              ),
              TextSkelton(width: size.width / 1.3),
              SizedBox(
                height: height,
              ),
              TextSkelton(width: size.width / 1.1),
              SizedBox(
                height: height,
              ),
              TextSkelton(width: size.width / 1.2),
              SizedBox(
                height: height,
              ),
              TextSkelton(width: size.width / 1.1),
              SizedBox(
                height: height,
              ),
              TextSkelton(width: size.width / 5),
              SizedBox(
                height: height,
              ),
            ]),
      ),
    );
  }
}
