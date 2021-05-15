import 'package:http/http.dart' as http;

class Github {
  final String username;
  final String url = 'https://api.github.com/';
  static String client_id = 'd615e032e23a4925f8e7';
  static String client_secret = '0cd309b6a350c1944db103f3a9bd0b453b9dc5b0';

  String query = '?client_Id=$client_id&client_secret=$client_secret';

  Github(this.username);

  Future<http.Response> fetchUser() {
    return http.get(url + 'user/' + username + query);
  }

  Future<http.Response> fetchFollowing() {
    return http.get(url + 'user/' + username + '/following' + query);
  }
}
