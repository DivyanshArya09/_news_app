import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/colors/app_colors.dart';

class NewsTile extends StatelessWidget {
  final String publishedAt, title, name;
  final String? urlToImage;
  final VoidCallback onTap;
  const NewsTile(
      {super.key,
      required this.publishedAt,
      required this.title,
      required this.name,
      required this.urlToImage,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: size.height * .2,
          width: size.width,
          decoration: BoxDecoration(
            color: AppColors.navItemsBackground,
            borderRadius: BorderRadius.circular(10),
          ),
          child: LayoutBuilder(
            builder: (_, constraints) {
              return Row(
                children: [
                  SizedBox(
                    height: constraints.maxHeight,
                    width: constraints.maxWidth / 2.5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FancyShimmerImage(
                        imageUrl: urlToImage!,
                        boxFit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: constraints.maxHeight / 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                              fontSize: 13,
                              color: Color.fromARGB(255, 129, 128, 128)),
                        ),
                        SizedBox(
                          width: constraints.maxWidth / 2.4,
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 17,
                              color: AppColors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          publishedAt,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 129, 128, 128),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
