import 'package:flutter/foundation.dart';
import 'package:flutter_logique/data/database/db_friend_helper.dart';
import 'package:flutter_logique/data/model/response/friend/friend.dart';
import 'package:flutter_logique/utils/result_state.dart';

class DbFriendProvider extends ChangeNotifier {
  final DbFriendHelper databaseHelper;

  DbFriendProvider({required this.databaseHelper}) {
    _getFavorites();
  }

  ResultState? _stateFavorite;

  ResultState? get state => _stateFavorite;

  String _message = '';

  String get message => _message;

  List<Friend> _myFavorite = [];

  List<Friend> get myFavorite => _myFavorite;

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

  void addFriend(Friend friend) async {
    try {
      await databaseHelper.addFriend(friend);
      _getFavorites();
    } catch (e) {
      _stateFavorite = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFriend(String url) async {
    final friend = await databaseHelper.getFriendById(url);
    return friend.isNotEmpty;
  }

  void removeFriend(String url) async {
    try {
      await databaseHelper.removeFriend(url);
      _getFavorites();
    } catch (e) {
      _stateFavorite = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
