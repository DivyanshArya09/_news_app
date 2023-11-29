import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../colors/api_key.dart';
import '../models/article_model.dart';
import 'country_language.dart';

class SearchAndCategoryApiHandler with ChangeNotifier {
  String countryCode = CountryAndLanguageServices.defaultCountryCode;
  // recommend news
  int recommededNewsPage = 1;
  List<Article> recommendedArticles = [];

  // searched news
  List<Article> searchedNews = [];
  int searchedNewsPage = 1;
  bool somethingWentWrong = false;
  // category
  int fetchingNewsIndex = 0;
  List<int> allNewsPageList = [1, 1, 1, 1, 1, 1, 1, 1];
  List<List<Article>> sepratedCategoryList = [
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
  ];
  List categories = [
    'all',
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology',
  ];
  List<bool> isPressed = [
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  List<Article> categoryNews = [];

  bool isCategoryNewsLoading = false;
  bool isRecommendedNewsLoading = false;

  Future<void> fetchSearchedNews(String query) async {
    isCategoryNewsLoading = true;
    notifyListeners();
    String url =
        'https://newsapi.org/v2/everything?q=$query&page=$searchedNewsPage&pageSize=10&apiKey=$API_Key';
    var uri = Uri.parse(url);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List articles = data['articles'];
      List<Article> newArticles =
          articles.map((article) => Article.fromJson(article)).toList();
      searchedNews.addAll(newArticles);
      searchedNewsPage++;
      if (searchedNews.isEmpty) {
        somethingWentWrong = true;
        isCategoryNewsLoading = false;
        notifyListeners();
      }
    } else {
      notifyListeners();
      throw Exception('Failed to load news articles');
    }
    isCategoryNewsLoading = false;
    notifyListeners();
  }

  Future<void> fetchCategory(
      String category, String country, int pageCount, int idx) async {
    isCategoryNewsLoading = true;
    notifyListeners();
    String url =
        'https://newsapi.org/v2/top-headlines?country=$countryCode&category=$category&page=$allNewsPageList[idx]&pageSize=$pageCount&apiKey=$API_Key';
    var uri = Uri.parse(url);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List articles = data['articles'];
      List<Article> newArticles =
          articles.map((article) => Article.fromJson(article)).toList();
      sepratedCategoryList[idx].addAll(newArticles);
      allNewsPageList[idx]++;
    } else {
      throw Exception('Failed to load news articles');
    }
    isCategoryNewsLoading = false;
    notifyListeners();
  }

  Future<void> fetchRecommendedNews(
      String country, int pageCount, int idx) async {
    String category = categories[idx];
    isRecommendedNewsLoading = true;
    notifyListeners();
    String url =
        'https://newsapi.org/v2/top-headlines?country=$countryCode&category=$category&page=$recommededNewsPage&pageSize=$pageCount&apiKey=$API_Key';
    var uri = Uri.parse(url);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List articles = data['articles'];
      List<Article> newArticles =
          articles.map((article) => Article.fromJson(article)).toList();
      recommendedArticles.addAll(newArticles);
      recommededNewsPage++;
    } else {
      throw Exception('Failed to load news articles');
    }
    isRecommendedNewsLoading = false;
    notifyListeners();
  }

  Future<void> fetchMoreRecommendedNews(
      String country, int pageCount, int idx) async {
    String category = categories[idx];
    isRecommendedNewsLoading = true;
    notifyListeners();
    String url =
        'https://newsapi.org/v2/top-headlines?country=$countryCode&category=$category&page=$recommededNewsPage&pageSize=$pageCount&apiKey=$API_Key';
    var uri = Uri.parse(url);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List articles = data['articles'];
      List<Article> newArticles =
          articles.map((article) => Article.fromJson(article)).toList();
      recommendedArticles.clear();
      recommendedArticles.addAll(newArticles);
      recommededNewsPage++;
    } else {
      throw Exception('Failed to load news articles');
    }
    isRecommendedNewsLoading = false;
    notifyListeners();
  }

  void toggle(int idx) {
    for (var i = 0; i < isPressed.length; i++) {
      if (i == idx) {
        isPressed[i] = true;
      } else {
        isPressed[i] = false;
      }
    }
    notifyListeners();
  }

  void fetchedIndex(int idx) {
    fetchingNewsIndex = idx;
    notifyListeners();
  }
}
