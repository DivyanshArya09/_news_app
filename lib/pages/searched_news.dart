import 'package:flutter/material.dart';
import 'package:news_app/colors/app_colors.dart';
import 'package:news_app/components/news_container.dart';
import 'package:news_app/pages/web_view.dart';
import 'package:news_app/services/search_api_handler.dart';
import 'package:provider/provider.dart';

import 'errorPages/something_went_wrong.dart';
import '../skeltons/skelton_news_container.dart';

class SearchedNews extends StatefulWidget {
  final String text;
  const SearchedNews({super.key, required this.text});

  @override
  State<SearchedNews> createState() => _SearchedNewsState();
}

class _SearchedNewsState extends State<SearchedNews> {
  final scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    final provider =
        Provider.of<SearchAndCategoryApiHandler>(context, listen: false);

    Future.delayed(Duration.zero).then(
      (value) {
        provider.fetchSearchedNews(widget.text.toLowerCase());
      },
    );
    scrollController.addListener(
      () {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          provider.fetchSearchedNews(
            widget.text.toLowerCase(),
          );
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<SearchAndCategoryApiHandler>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        provider.searchedNews.clear();
        provider.searchedNewsPage = 1;
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Results for ${widget.text}'),
        ),
        body: Column(
          children: [
            Consumer<SearchAndCategoryApiHandler>(
              builder: (context, value, child) {
                return value.somethingWentWrong
                    ? const SomeThingWentWrong()
                    : value.searchedNews.isEmpty
                        ? Expanded(
                            child: ListView.builder(
                                itemBuilder: (context, index) =>
                                    const SkeltonNewsContainer(),
                                itemCount: 10),
                          )
                        : Expanded(
                            child: ListView.builder(
                              controller: scrollController,
                              itemCount: value.searchedNews.length + 1,
                              itemBuilder: (context, index) {
                                return index < value.searchedNews.length
                                    ? NewsContainer(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => MyWebView(
                                                url: value
                                                    .searchedNews[index].url
                                                    .toString(),
                                              ),
                                            ),
                                          );
                                        },
                                        urlToImage: value
                                            .searchedNews[index].urlToImage
                                            .toString(),
                                        title: value.searchedNews[index].title
                                            .toString(),
                                        description: value
                                            .searchedNews[index].description
                                            .toString())
                                    : const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 32),
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      );
                              },
                            ),
                          );
              },
            ),
          ],
        ),
      ),
    );
  }
}
