import 'dart:convert';

import 'package:news_webapp/models/newsArticle_model.dart';
import 'package:http/http.dart' as http;

class WebService {
  Future<List<NewsArticle>> fetchTopHeadlines() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=1332ab69b5d84e6a8f3ea889f780e092";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      Iterable list = jsonData["articles"];

      //print(result['articles']);
      // print(list.map((article) => NewsArticle.fromJson(article)).toList());

      return list.map((article) => NewsArticle.fromJson(article)).toList();
    } else {
      throw Exception("failed to fetch top news");
    }
  }
}
