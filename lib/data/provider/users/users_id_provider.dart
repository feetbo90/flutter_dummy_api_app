
import 'package:flutter/material.dart';
import 'package:flutter_logique/data/api/api_services.dart';
import 'package:flutter_logique/data/model/response/users/user_detail.dart';
import 'package:flutter_logique/utils/result_state.dart';

class UsersIdProvider with ChangeNotifier {
  final ApiService apiService;

  UsersIdProvider({required this.apiService});
  late UserDetail _userResults;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  ResultState get state => _state;

  UserDetail get result => _userResults;

  Future<dynamic> fetchUsersById(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final users = await apiService.getUsersById(id);
      if (users.id == null) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _userResults = users;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
