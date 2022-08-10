import 'package:flutter_logique/data/model/response/posts/posts.dart';
import 'package:flutter_logique/data/model/response/users/user_detail.dart';
import 'package:flutter_logique/data/model/response/users/users.dart';
import 'package:flutter_logique/utils/config.dart';
import 'package:http/http.dart' as http;

class ApiService {
  http.Client client;

  ApiService(this.client);

  Future<Users> getUsers(int page, int limit) async {
    try {
      Map<String, String> headers = {
        'app-id': Config.appId,
        "Content-Type": "application/json",
        "Accept": "application/json",
      };
      final response = await client.get(Uri.parse('${Config.url}data/v1/user?page=$page&limit=$limit'),
          headers: headers);

      if (response.statusCode == 200) {
        return usersFromJson(response.body);
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<UserDetail> getUsersById(String id) async {
    try {
      Map<String, String> headers = {
        'app-id': Config.appId,
        "Content-Type": "application/json",
        "Accept": "application/json",
      };
      final response = await client.get(Uri.parse('${Config.url}data/v1/user/$id'),
          headers: headers);
      if (response.statusCode == 200) {
        return userDetailFromJson(response.body);
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Posts> getPostsById(String id, int page, int limit) async {
    try {
      Map<String, String> headers = {
        'app-id': Config.appId,
        "Content-Type": "application/json",
        "Accept": "application/json",
      };
      // print('url: ${Config.url}data/v1/user/$id/post?page=$page&limit=$limit');
      final response = await client.get(Uri.parse('${Config.url}data/v1/user/$id/post?page=$page&limit=$limit'),
          headers: headers);
      if (response.statusCode == 200) {
        return postsFromJson(response.body);
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Posts> getPosts(int page, int limit) async {
    try {
      Map<String, String> headers = {
        'app-id': Config.appId,
        "Content-Type": "application/json",
        "Accept": "application/json",
      };
      final response = await client.get(Uri.parse('${Config.url}data/v1/post?page=$page&limit=$limit'),
          headers: headers);

      if (response.statusCode == 200) {
        return postsFromJson(response.body);
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Posts> getTagPosts(String tag, int page, int limit) async {
    try {
      Map<String, String> headers = {
        'app-id': Config.appId,
        "Content-Type": "application/json",
        "Accept": "application/json",
      };
      final response = await client.get(Uri.parse('${Config.url}data/v1/tag/$tag/post?page=$page&limit=$limit'),
          headers: headers);
      if (response.statusCode == 200) {
        return postsFromJson(response.body);
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

}
