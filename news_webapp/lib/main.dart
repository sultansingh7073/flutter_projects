import 'package:flutter/material.dart';
import 'package:news_webapp/viewModel/news_article_list_viewModel.dart';
import 'package:news_webapp/views/news_Screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FastNews.com',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => NewsArticleListViewModel()),
      ], child: NewsScreen()),
    );
  }
}
