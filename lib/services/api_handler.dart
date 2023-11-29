import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:news_app/colors/api_key.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/article_model.dart';

import 'country_language.dart';

class ApiHandler with ChangeNotifier {
  String countryCode = CountryAndLanguageServices.defaultCountryCode;
  List<Article> breakingNewsArticles = [];
  List<Article> allNewsArticles = [];
  int breakingNewsPage = 1;
  int allNewsPage = 1;
  bool isBreakingNewsLoading = false;
  bool isAllNewsLoading = false;

  Future<void> fetchBreakingNews(int pageCount, String country) async {
    isBreakingNewsLoading = true;
    notifyListeners();
    String url =
        'https://newsapi.org/v2/top-headlines?country=$countryCode&page=$breakingNewsPage&pageSize=$pageCount&apiKey=$API_Key';
    var uri = Uri.parse(url);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List articles = data['articles'];
      List<Article> newArticles =
          articles.map((article) => Article.fromJson(article)).toList();
      breakingNewsArticles.addAll(newArticles);
      breakingNewsPage++;
    } else {
      throw Exception('Failed to load news articles');
    }
    isBreakingNewsLoading = false;
    notifyListeners();
  }

  Future<void> fetchMoreBreakingNews(int pageCount, String country) async {
    isBreakingNewsLoading = true;
    notifyListeners();
    String url =
        'https://newsapi.org/v2/top-headlines?country=$countryCode&page=$breakingNewsPage&pageSize=$pageCount&apiKey=$API_Key';
    var uri = Uri.parse(url);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List articles = data['articles'];
      List<Article> newArticles =
          articles.map((article) => Article.fromJson(article)).toList();
      breakingNewsArticles.clear();
      breakingNewsArticles.addAll(newArticles);
      breakingNewsPage++;
      notifyListeners();
    } else {
      throw Exception('Failed to load news articles');
    }
    isBreakingNewsLoading = false;
    notifyListeners();
  }

  Future<void> fetchAllNews(int pageCount, String query) async {
    isAllNewsLoading = true;
    notifyListeners();
    String url =
        'https://newsapi.org/v2/everything?q=$query&page=$allNewsPage&pageSize=$pageCount&apiKey=$API_Key';
    var uri = Uri.parse(url);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List articles = data['articles'];
      List<Article> newArticles =
          articles.map((article) => Article.fromJson(article)).toList();
      allNewsArticles.addAll(newArticles);
      allNewsPage++;
      // notifyListeners();
    } else {
      throw Exception('Failed to load news articles');
    }
    isAllNewsLoading = false;
    notifyListeners();
  }

  void fetchWholedata() {
    breakingNewsArticles.clear();
    allNewsPage = 1;
    breakingNewsPage = 1;
    fetchBreakingNews(10, '');
  }
}
