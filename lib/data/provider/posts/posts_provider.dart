import 'package:flutter/material.dart';
import 'package:flutter_logique/data/api/api_services.dart';
import 'package:flutter_logique/data/model/response/posts/posts.dart';
import 'package:flutter_logique/utils/result_state.dart';

class PostsProvider extends ChangeNotifier {
  final ApiService apiService;

  PostsProvider({required this.apiService}) {
    fetchPosts();
  }

  late Posts _postsResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  ResultState get state => _state;

  Posts get result => _postsResult;

  final List<Datum> _datumResults = [];

  List<Datum> get datumResults => _datumResults;

  int _pageNumber = 0;

  int get pageNumber => _pageNumber;

  final int _limit = 20;
  final int _nextPageThreshold = 5;

  int get nextPageThreshold => _nextPageThreshold;

  bool _hasMore = true;

  bool get hasMore => _hasMore;

  int _data = 1;

  Future<dynamic> fetchPosts() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      if (_data > _datumResults.length) {
        final posts = await apiService.getPosts(_pageNumber, _limit);
        if (posts.data.isEmpty) {
          _state = ResultState.noData;
          notifyListeners();
          return _message = 'Empty Data';
        } else {
          _state = ResultState.hasData;
          _hasMore = posts.data.length == _limit;
          _datumResults.addAll(posts.data);
          _pageNumber = _pageNumber + 1;
          _data = posts.total;
          notifyListeners();
          return _datumResults;
        }
      } else {
        return _datumResults;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
