import 'package:flutter/material.dart';
import 'package:flutter_logique/data/api/api_services.dart';
import 'package:flutter_logique/data/model/response/users/users.dart';
import 'package:flutter_logique/utils/result_state.dart';

class UsersProvider extends ChangeNotifier {
  final ApiService apiService;

  UsersProvider({required this.apiService}) {
    fetchUsers();
  }

  late Users _userResults;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  ResultState get state => _state;

  Users get result => _userResults;

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

  Future<dynamic> fetchUsers() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      if (_data > _datumResults.length) {
        final users = await apiService.getUsers(_pageNumber, _limit);
        if (users.data.isEmpty) {
          _state = ResultState.noData;
          notifyListeners();
          return _message = 'Empty Data';
        } else {
          _state = ResultState.hasData;
          _hasMore = users.data.length == _limit;
          _datumResults.addAll(users.data);
          _pageNumber = _pageNumber + 1;
          _data = users.total;
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
