import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:github_follower_app/models/user.dart';
import 'package:github_follower_app/requests/githubRequest.dart';

class UserProvider with ChangeNotifier {
  User user;
  String errorMessage;
  bool loading = false;

  Future<bool> fetchUser(username) async {
    setLoading(true);
    Github(username).fetchUser().then((data) {
      if (data.statusCode == 200) {
        setUser(User.fromJson(json.decode(data.body)));
      } else {
        Map<String, dynamic> result = json.decode(data.body);
        setMessage(result['message']);
      }
    });
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  void setUser(value) {
    user = value;
    notifyListeners();
  }

  void setMessage(value) {
    errorMessage = value;
    notifyListeners();
  }
}
