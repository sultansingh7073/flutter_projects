class User {
  String login;
  String avatarUrl;
  String htmlUrl;

  User(this.login, this.avatarUrl, this.htmlUrl);

  User.fromJson(Map json) {
    login = json['login'];
    avatarUrl = json['avatarUrl'];
    htmlUrl = json['htmlUrl'];
  }
  Map toJson() {
    return {'login': login, 'avatar_url': avatarUrl, 'html_url': htmlUrl};
  }
}
