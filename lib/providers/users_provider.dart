import 'package:chat_app_nodejs/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  List<UserModel> users = <UserModel>[
    UserModel(id: '1', name: 'mohamed'),
    UserModel(id: '2', name: 'syed'),
    UserModel(id: '3', name: 'suliman'),
    UserModel(id: '4', name: 'abbas'),
  ];
  //
  final resetUsers = <UserModel>[
    UserModel(id: '1', name: 'mohamed'),
    UserModel(id: '2', name: 'syed'),
    UserModel(id: '3', name: 'suliman'),
    UserModel(id: '4', name: 'abbas'),
  ];
  //
  UserModel _currentUser = UserModel(id: '', name: '');
  UserModel _loginUser = UserModel(id: '', name: '');

  UserModel get currentUser => _currentUser;
  UserModel get loginUser => _currentUser;
  //
  void setLoginUser(UserModel userModel) {
    _loginUser = userModel;
    debugPrint('_loginUser user = ${_loginUser.name}');
    removeUser(userModel);
    notifyListeners();
  } //

  void selectTargetUser(UserModel userModel) {
    _currentUser = userModel;
    debugPrint('selectUser user = ${_currentUser.name}');
    removeUser(userModel);
    notifyListeners();
  }

  void removeUser(UserModel userModel) {
    users.remove(userModel);
  }

  void getUsers() {
    users = resetUsers;
    notifyListeners();
  }
}
