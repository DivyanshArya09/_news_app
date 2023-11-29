import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

class NewsContainer extends StatelessWidget {
  final String urlToImage, title, description;
  final VoidCallback onTap;
  const NewsContainer(
      {super.key,
      required this.urlToImage,
      required this.title,
      required this.description,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: AppColors
                .lightgrey, // Replace with your desired container color
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(children: [
            SizedBox(
              height: size.height * .3,
              width: size.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FancyShimmerImage(
                  imageUrl: urlToImage,
                  boxFit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 13,
            ),
            Wrap(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 20.0,
                      color: AppColors.black,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 13,
            ),
            Wrap(
              children: [
                Text(
                  description,
                  style:
                      const TextStyle(fontSize: 16.0, color: AppColors.black),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
