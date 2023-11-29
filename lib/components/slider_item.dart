import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/colors/app_colors.dart';

class SliderItem extends StatefulWidget {
  final String title, description, source, time;
  final String urlToImage;
  final VoidCallback onTap;
  const SliderItem({
    super.key,
    required this.onTap,
    required this.urlToImage,
    required this.title,
    required this.description,
    required this.source,
    required this.time,
  });

  @override
  State<SliderItem> createState() => _SliderItemState();
}

class _SliderItemState extends State<SliderItem> {
  @override
  Widget build(BuildContext context) {
    String imageVariable = widget.urlToImage == ''
        ? 'https://wd.imgix.net/image/kheDArv5csY6rvQUJDbWRscckLr1/t98X06XyMtNI4rTmXyfZ.jpg?auto=format'
        : widget.urlToImage;
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          // padding: const EdgeInsets.all(15),
          height: size.height * .35,
          width: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          child: Stack(
            children: [
              Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: FancyShimmerImage(
                      boxDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      imageUrl: imageVariable,
                      boxFit: BoxFit.cover,
                    ),
                  )),
              Positioned(
                  child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black.withOpacity(.7),
                ),
              )),
              Positioned(
                bottom: 15,
                left: 15,
                right: 15,
                child: SizedBox(
                  height: size.height * .2,
                  width: size.width * .85,
                  // width: 50,
                  // color: Colors.red,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: widget.title,
                              style: const TextStyle(
                                color: AppColors.navItemsBackground,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: ' • ${widget.time}',
                              style: const TextStyle(
                                color: AppColors.navItemsBackground,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        widget.description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        style: const TextStyle(
                          fontSize: 20,
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 15,
                left: 15,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      widget.source,
                      style: const TextStyle(color: AppColors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
