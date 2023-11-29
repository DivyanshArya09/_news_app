import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/colors/app_colors.dart';
import 'package:news_app/components/news_container.dart';
import 'package:news_app/pages/web_view.dart';
// import 'package:news_app/services/api_handler.dart';
import 'package:news_app/skeltons/news_tile_skelton.dart';
// import 'package:news_app/skeltons/skelton_container.dart';
import 'package:provider/provider.dart';

import '../services/search_api_handler.dart';

class RecommendedNewsPage extends StatefulWidget {
  const RecommendedNewsPage({super.key});

  @override
  State<RecommendedNewsPage> createState() => _RecommendedNewsPageState();
}

class _RecommendedNewsPageState extends State<RecommendedNewsPage> {
  final scrollController = ScrollController();

  int getRandomNumber() {
    Random random = Random();
    return random.nextInt(7) + 1;
  }

  @override
  void initState() {
    // TODO: implement initState
    int randomNumber = getRandomNumber();
    final provider =
        Provider.of<SearchAndCategoryApiHandler>(context, listen: false);
    Future.delayed(Duration.zero).then(
      (value) {
        provider.fetchRecommendedNews('in', 10, randomNumber);
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
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<SearchAndCategoryApiHandler>(context, listen: false);

    Future<void> onRefresh() async {
      int randomNumber = getRandomNumber();
      provider.fetchMoreRecommendedNews('in', 10, randomNumber);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recommended News'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Consumer<SearchAndCategoryApiHandler>(
            builder: ((context, value, child) {
              return Expanded(
                child: value.recommendedArticles.isEmpty
                    ? ListView.builder(
                        itemCount: 10,
                        itemBuilder: (_, idx) {
                          return const NewsTitleSkelton();
                        },
                      )
                    : RefreshIndicator(
                        onRefresh: onRefresh,
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: value.recommendedArticles.length + 1,
                          itemBuilder: (context, index) {
                            return index < value.recommendedArticles.length
                                ? NewsContainer(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MyWebView(
                                            url: value
                                                .recommendedArticles[index].url
                                                .toString(),
                                          ),
                                        ),
                                      );
                                    },
                                    urlToImage: value
                                        .recommendedArticles[index].urlToImage
                                        .toString(),
                                    description: value
                                                .recommendedArticles[index]
                                                .description ==
                                            null
                                        ? ''
                                        : value.recommendedArticles[index]
                                            .description
                                            .toString(),
                                    title: value
                                        .recommendedArticles[index].title
                                        .toString(),
                                  )
                                : const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 32),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  );
                          },
                        ),
                      ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
