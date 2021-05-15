import 'package:news_webapp/models/newsArticle_model.dart';

class NewsArticleViewModel {
  NewsArticle newsArticle;

  NewsArticleViewModel({required this.newsArticle});
  String get title {
    return newsArticle.title;
  }

  String get description {
    return newsArticle.description;
  }

  String get imageUrl {
    return newsArticle.urlToImage;
  }

  String get url {
    return newsArticle.url;
  }

  String get content {
    return newsArticle.content;
  }

  String get publishedAt {
    // final dateTime = DateFormat('yyyy-MM-ddTHH:mm:ssZ').parse(_newsArticle.publishedAt, true);
    // return DateFormat.yMMMMEEEEd('en-us').format(dateTime).toString();
    return newsArticle.publishedAt;
  }

  get urlToImage => null;
}
