import 'package:flutter/material.dart';
import 'package:news_app/components/category_container.dart';
import 'package:news_app/components/news_container.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/pages/searched_news.dart';
import 'package:news_app/pages/web_view.dart';
import 'package:news_app/services/search_api_handler.dart';
import 'package:provider/provider.dart';
import '../colors/app_colors.dart';
import '../skeltons/news_tile_skelton.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  final scrollController = ScrollController();

  @override
  void initState() {
    final provider =
        Provider.of<SearchAndCategoryApiHandler>(context, listen: false);
    // TODO: implement initState
    Future.delayed(Duration.zero).then((value) {
      provider.fetchCategory('general', 'us', 10, 0);
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        provider.fetchCategory(provider.categories[provider.fetchingNewsIndex],
            'in', 10, provider.fetchingNewsIndex);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Article> seprateCategory = [];
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<SearchAndCategoryApiHandler>(
        builder: (context, provider, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * .05),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .05),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BackButton(
                      color: AppColors.black,
                    ),
                    SizedBox(height: size.height * .01),
                    const Text(
                      'Discover',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    const Text(
                      'News from all around the world',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 168, 167, 167),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    // SearchNews(
                    //   onTap: () {},
                    //   searchController: searchController,
                    // ),
                    SizedBox(
                      width: size.width * .9,
                      height: 50,
                      child: TextField(
                        onSubmitted: (value) {
                          value.isEmpty
                              ? FocusScope.of(context).unfocus()
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SearchedNews(
                                      text: value,
                                    ),
                                  ),
                                ).then((val) => searchController.text = '');
                        },
                        controller: searchController,
                        decoration: const InputDecoration(
                          fillColor: AppColors.lightgrey,
                          filled: true,
                          hintText: 'Search',
                          hintStyle: TextStyle(color: AppColors.grey),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                          prefixIcon: Icon(Icons.search, color: AppColors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: provider.categories.length,
                itemBuilder: (_, index) {
                  return CategoryContainer(
                    category: provider.categories[index],
                    onTap: () {
                      provider.toggle(index);
                      if (provider.sepratedCategoryList[index].isEmpty) {
                        provider.fetchCategory(
                            provider.categories[index], 'in', 10, index);
                      }
                      provider.fetchedIndex(index);
                    },
                    isPressed: provider.isPressed[index],
                  );
                },
              ),
            ),
            Expanded(
              child: provider
                      .sepratedCategoryList[provider.fetchingNewsIndex].isEmpty
                  ? ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (_, idx) {
                        return const NewsTitleSkelton();
                      })
                  : RefreshIndicator(
                      onRefresh: () {
                        return Future.delayed(
                          const Duration(seconds: 2),
                        );
                      },
                      child: ListView.builder(
                        controller: scrollController,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider
                                .sepratedCategoryList[
                                    provider.fetchingNewsIndex]
                                .length +
                            1,
                        itemBuilder: (_, index) {
                          seprateCategory = provider
                              .sepratedCategoryList[provider.fetchingNewsIndex];
                          return index <
                                  provider
                                      .sepratedCategoryList[
                                          provider.fetchingNewsIndex]
                                      .length
                              ? NewsContainer(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MyWebView(
                                          url: seprateCategory[index]
                                              .url
                                              .toString(),
                                        ),
                                      ),
                                    );
                                  },
                                  description: seprateCategory[index]
                                      .description
                                      .toString(),
                                  title:
                                      seprateCategory[index].title.toString(),
                                  urlToImage: seprateCategory[index]
                                      .urlToImage
                                      .toString(),
                                )
                              : const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 32),
                                  child: Center(
                                      child: CircularProgressIndicator(
                                    color: AppColors.primary,
                                  )),
                                );
                          // return const NewsTitleSkelton();
                        },
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
