class NewsArticle {
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  NewsArticle(
      {required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      required this.publishedAt,
      required this.content});
  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
        title: json['title'] == null ? "" : json['title'],
        description: json['description'] == null ? "" : json['description'],
        url: json['url'] == null ? "" : json['url'],
        urlToImage: json['urlToImage'] == null ? "" : json['urlToImage'],
        publishedAt: json['publishedAt'] == null ? "" : json['publishedAt'],
        content: json['content'] == null ? "" : json['content']);
  }
}
