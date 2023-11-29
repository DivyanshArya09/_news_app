import 'package:flutter/material.dart';
import 'package:news_app/skeltons/text_skelton.dart';
import 'package:shimmer/shimmer.dart';

import '../colors/app_colors.dart';

class NewsTitleSkelton extends StatelessWidget {
  const NewsTitleSkelton({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: size.height * .2,
        width: size.width,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: LayoutBuilder(
          builder: (_, constraints) {
            return Row(
              children: [
                Shimmer.fromColors(
                  baseColor: AppColors.skeltonColor,
                  highlightColor: AppColors.white,
                  period: const Duration(seconds: 1),
                  child: SizedBox(
                    height: constraints.maxHeight,
                    width: constraints.maxWidth / 2.5,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          color: AppColors.skeltonColor,
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: constraints.maxHeight / 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextSkelton(width: 40),
                      TextSkelton(width: constraints.maxHeight),
                      TextSkelton(width: constraints.maxHeight / 1.1),
                      TextSkelton(width: constraints.maxHeight / 1.2),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextSkelton(width: 40),
                          TextSkelton(width: 40),
                        ],
                      )
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
