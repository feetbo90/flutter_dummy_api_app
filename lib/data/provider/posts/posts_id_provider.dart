import 'package:flutter/material.dart';
import 'package:flutter_logique/data/api/api_services.dart';
import 'package:flutter_logique/data/model/response/posts/posts.dart';
import 'package:flutter_logique/utils/result_state.dart';

class PostsIdProvider extends ChangeNotifier {
  final ApiService apiService;

  PostsIdProvider({required this.apiService});

  late Posts _postsResult;
  late ResultState _state;
  String _message = '';
  String _query = "";

  String get message => _message;

  ResultState get state => _state;

  Posts get result => _postsResult;

  List<Datum> _datumResults = [];
  List<Datum> _tempResults = [];

  List<Datum> get datumResults => _datumResults;

  int _pageNumber = 0;

  int get pageNumber => _pageNumber;

  final int _limit = 20;
  final int _nextPageThreshold = 5;

  int get nextPageThreshold => _nextPageThreshold;

  bool _hasMore = true;

  bool get hasMore => _hasMore;

  int _data = 1;

  Future<dynamic> fetchPostsById(String id, int myPage) async {
    try {
      if(myPage == 1) {
        _pageNumber =0;
        _datumResults = [];
      }
      _state = ResultState.loading;
      notifyListeners();
      if (_data > _datumResults.length) {
        final posts = await apiService.getPostsById(id, _pageNumber, _limit);
        if (posts.data.isEmpty) {
          _state = ResultState.noData;
          notifyListeners();
          return _message = 'Empty Data';
        } else {
          _state = ResultState.hasData;
          _hasMore = posts.data.length == _limit;
          // _datumResults.addAll(posts.data);
          _datumResults = posts.data;
          _pageNumber = _pageNumber + 1;
          _data = posts.total;
          // _tempResults = _datumResults;
          notifyListeners();
          return _datumResults;
        }
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _datumResults;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> searchByQuery(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      // _datumResults = _tempResults;
      _tempResults = _datumResults;

      for(int i = 0; i< _tempResults.length; i++) {
        if(!_tempResults[i].text.contains(query)) {
          _tempResults.removeAt(i);
        }
      }
      _datumResults = _tempResults;
      _state = ResultState.hasData;
      notifyListeners();
      return _datumResults;
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  void onSearch(String query) {
    _query = query;
    if (_query.isEmpty) {
      _pageNumber =0;
      _datumResults = [];
      // _fetchAllRestaurants();
    } else {
      _pageNumber =0;
      _tempResults = [];
      searchByQuery(query);
    }
  }
}
