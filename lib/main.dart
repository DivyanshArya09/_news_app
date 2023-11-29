import 'package:flutter/material.dart';
import 'package:news_app/pages/home_page.dart';
import 'package:news_app/services/api_handler.dart';
import 'package:news_app/services/country_language.dart';
import 'package:news_app/services/search_api_handler.dart';
import 'package:provider/provider.dart';
// import 'package:news_app/pages/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ApiHandler(),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchAndCategoryApiHandler(),
        ),
        ChangeNotifierProvider(
          create: (_) => CountryAndLanguageServices(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News app',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
