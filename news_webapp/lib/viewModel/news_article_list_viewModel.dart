import 'package:flutter/material.dart';

import 'package:news_webapp/services/web_service.dart';
import 'package:news_webapp/viewModel/news_article_viewModel.dart';

enum LoadingStatus { completed, searching, empty }

class NewsArticleListViewModel with ChangeNotifier {
  LoadingStatus loadingStatus = LoadingStatus.empty;
  List<NewsArticleViewModel> articles = <NewsArticleViewModel>[];
  List<NewsArticleViewModel> get getArticles => articles;
  void topHeadlines() async {
    final newsArticle = await WebService().fetchTopHeadlines();

    articles = newsArticle
        .map((item) => NewsArticleViewModel(newsArticle: item))
        .toList();
    print(articles[0].title);
    notifyListeners();
  }
}
