import 'package:flutter/material.dart';
import 'package:news_app/colors/app_colors.dart';
import 'package:news_app/components/news_container.dart';
import 'package:news_app/pages/web_view.dart';
import 'package:news_app/services/api_handler.dart';
import 'package:provider/provider.dart';
import '../skeltons/skelton_news_container.dart';

class BreakingNewsPage extends StatefulWidget {
  const BreakingNewsPage({super.key});

  @override
  State<BreakingNewsPage> createState() => _BreakingNewsPageState();
}

class _BreakingNewsPageState extends State<BreakingNewsPage> {
  final scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    final provider = Provider.of<ApiHandler>(context, listen: false);
    Future.delayed(Duration.zero).then(
      (value) {
        provider.fetchBreakingNews(10, 'in');
      },
    );
    scrollController.addListener(
      () {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          provider.fetchBreakingNews(10, 'in');
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
    final provider = Provider.of<ApiHandler>(context, listen: false);
    Future<void> onRefresh() async {
      provider.fetchMoreBreakingNews(10, 'in');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Breaking News'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Consumer<ApiHandler>(
            builder: ((context, value, child) {
              return Expanded(
                child: value.breakingNewsArticles.length < 10 ||
                        value.isAllNewsLoading
                    ? ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return const SkeltonNewsContainer();
                        })
                    : ListView.builder(
                        controller: scrollController,
                        itemCount: value.breakingNewsArticles.length + 1,
                        itemBuilder: (context, index) {
                          return index < value.breakingNewsArticles.length
                              ? NewsContainer(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MyWebView(
                                          url: value
                                              .breakingNewsArticles[index].url
                                              .toString(),
                                        ),
                                      ),
                                    );
                                  },
                                  urlToImage: value
                                      .breakingNewsArticles[index].urlToImage
                                      .toString(),
                                  description: value
                                      .breakingNewsArticles[index].description
                                      .toString(),
                                  title: value.breakingNewsArticles[index].title
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
              );
            }),
          ),
        ],
      ),
    );
  }
}
