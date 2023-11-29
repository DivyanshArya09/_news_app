import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app/colors/app_colors.dart';
import 'package:news_app/components/drawer.dart';
import 'package:news_app/components/news_tile.dart';
import 'package:news_app/pages/breakingnews_page.dart';
import 'package:news_app/pages/change_country.dart';
// import 'package:news_app/pages/breakingnews_page.dart';
import 'package:news_app/pages/recomended_page.dart';
import 'package:news_app/pages/search_page.dart';
import 'package:news_app/pages/web_view.dart';
import 'package:news_app/services/search_api_handler.dart';
import 'package:news_app/skeltons/skelton_container.dart';
import 'package:provider/provider.dart';

import '../components/slider_item.dart';
// import '../models/article_model.dart';
import '../services/api_handler.dart';
import '../shared/breaking_news.dart';
import '../skeltons/news_tile_skelton.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scrollController = ScrollController();

  String getValueBeforeT(String dateTimeString) {
    int indexOfT = dateTimeString.indexOf('T');
    if (indexOfT > 0) {
      return dateTimeString.substring(0, indexOfT);
    } else {
      return ''; // Return null if "T" is not found or at the beginning of the string.
    }
  }

  int getRandomNumber() {
    Random random = Random();
    return random.nextInt(7) + 1;
  }

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    int randomNumber = getRandomNumber();
    final provider =
        Provider.of<SearchAndCategoryApiHandler>(context, listen: false);
    final breakingNewsProvider =
        Provider.of<ApiHandler>(context, listen: false);
    Future.delayed(Duration.zero).then(
      (value) {
        provider.fetchRecommendedNews('in', 10, randomNumber);
        breakingNewsProvider.fetchBreakingNews(10, 'in');
      },
    );
    scrollController.addListener(
      () {
        int randomNumber = getRandomNumber();
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          provider.fetchRecommendedNews('in', 10, randomNumber);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final searchprovider =
        Provider.of<SearchAndCategoryApiHandler>(context, listen: false);
    final breakingNewsProvider =
        Provider.of<ApiHandler>(context, listen: false);
    Size size = MediaQuery.of(context).size;

    Future<void> onRefresh() async {
      int randomNumber = getRandomNumber();
      breakingNewsProvider.fetchMoreBreakingNews(10, 'in');
      searchprovider.fetchMoreRecommendedNews('in', 10, randomNumber);
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: AppColors.navItemsBackground,
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchPage(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.search,
                  color: AppColors.black,
                  size: 30,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: AppColors.navItemsBackground,
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChangeCountry(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.language)),
            ),
          )
        ],
      ),
      drawer: CustomDrawer(
        onTapCategory: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SearchPage(),
            ),
          );
        },
        onTapHotNews: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BreakingNewsPage(),
            ),
          );
        },
        onTapBreakingNews: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RecommendedNewsPage(),
            ),
          );
        },
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              BreakingNews(
                title: 'Breaking News',
                onTapOnViewAll: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BreakingNewsPage(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Consumer<ApiHandler>(
                builder: (_, value, child) {
                  return value.breakingNewsArticles.isNotEmpty
                      ? CarouselSlider.builder(
                          itemCount: value.breakingNewsArticles.length,
                          itemBuilder: (_, index, pageViewIndex) {
                            String newsDate = getValueBeforeT(
                              value.breakingNewsArticles[index].publishedAt
                                  .toString(),
                            );

                            return SliderItem(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyWebView(
                                      url: value.breakingNewsArticles[index].url
                                          .toString(),
                                    ),
                                  ),
                                );
                              },
                              urlToImage: value
                                  .breakingNewsArticles[index].urlToImage
                                  .toString(),
                              title: value.breakingNewsArticles[index].author
                                  .toString(),
                              description: value
                                  .breakingNewsArticles[index].title
                                  .toString(),
                              source: value
                                  .breakingNewsArticles[index].source!.name
                                  .toString(),
                              time: newsDate,
                            );
                          },
                          options: CarouselOptions(
                            enlargeCenterPage: true,
                            height: size.height * .35,
                            autoPlay: true,
                            viewportFraction: .95,
                          ),
                        )
                      : SkeltonContainer(
                          height: size.height * .35,
                          width: size.width * .95,
                          borderRadius: 15);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              BreakingNews(
                  onTapOnViewAll: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RecommendedNewsPage(),
                      ),
                    );
                  },
                  title: 'Recommendation'),
              const SizedBox(
                height: 10,
              ),
              Consumer<SearchAndCategoryApiHandler>(
                builder: (_, value, child) {
                  return value.recommendedArticles.isEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 10,
                          itemBuilder: (_, index) {
                            return const NewsTitleSkelton();
                          },
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: value.recommendedArticles.length,
                          itemBuilder: (context, index) {
                            String publishedAt = getValueBeforeT(value
                                .recommendedArticles[index].publishedAt
                                .toString());
                            return NewsTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyWebView(
                                              url: value
                                                  .recommendedArticles[index]
                                                  .url
                                                  .toString(),
                                            )));
                              },
                              title: value.recommendedArticles[index].title
                                  .toString(),
                              urlToImage: value
                                  .recommendedArticles[index].urlToImage
                                  .toString(),
                              publishedAt: publishedAt,
                              name: value
                                  .recommendedArticles[index].source!.name
                                  .toString(),
                            );
                          });
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
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
