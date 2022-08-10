import 'package:flutter/foundation.dart';
import 'package:flutter_logique/data/database/database_helper.dart';
import 'package:flutter_logique/data/model/response/posts/my_post.dart';
import 'package:flutter_logique/data/model/response/posts/posts.dart';
import 'package:flutter_logique/utils/convert.dart';
import 'package:flutter_logique/utils/result_state.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavorites();
  }

  ResultState? _stateFavorite;

  ResultState? get state => _stateFavorite;

  String _message = '';

  String get message => _message;

  List<MyPost> _myFavorite = [];

  List<MyPost> get myFavorite => _myFavorite;

  void _getFavorites() async {
    _myFavorite = await databaseHelper.getFavorites();
    if (_myFavorite.isNotEmpty) {
      _stateFavorite = ResultState.hasData;
    } else {
      _stateFavorite = ResultState.noData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addFavorites(Datum post) async {
    try {
      MyPost myPost = MyPost(
          id: post.id,
          image: post.image,
          likes: post.likes,
          tags: Convert.listToString(post.tags),
          text: post.text,
          publishDate: post.publishDate.toIso8601String(),
          owner: "${post.owner.id}#${post.owner.firstName}#${post.owner.lastName}#${post.owner.title}#${post.owner.picture}");

      await databaseHelper.insertFavorite(myPost);
      _getFavorites();
    } catch (e) {
      _stateFavorite = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  void addFavoritesTwo(MyPost post) async {
    try {
      await databaseHelper.insertFavorite(post);
      _getFavorites();
    } catch (e) {
      _stateFavorite = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String url) async {
    final favoritesRestaurant = await databaseHelper.getFavoriteById(url);
    return favoritesRestaurant.isNotEmpty;
  }

  void removeFavorite(String url) async {
    try {
      await databaseHelper.removeFavorite(url);
      _getFavorites();
    } catch (e) {
      _stateFavorite = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
