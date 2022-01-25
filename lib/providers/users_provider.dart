import 'package:chat_app_nodejs/models/user_model.dart';
import 'package:flutter/material.dart';

const userOne =
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSii53WPfyHRW5-yJ6rawU_l5gkJ6GVKMKR3DW0l9W-RVaEtqJFi6L6CTBvW3dLpI_8AoU&usqp=CAU';
//
const userTow =
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSii53WPfyHRW5-yJ6rawU_l5gkJ6GVKMKR3DW0l9W-RVaEtqJFi6L6CTBvW3dLpI_8AoU&usqp=CAU';
//
const userThree =
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSi8EO26WdA-KDg_Hn5Wx2X2FNAOxMeycBvhgmX5lTG7yJi_vgzMPM52cpPKwOE6sPDJO8&usqp=CAU';
//
const userFour =
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFtoH79XTQUHDDcY5aVQeQuVGonpjhUgNbzQ5oCbSS3HZiyw2v3JnWP342vKc1k4gse2U&usqp=CAU';

class UserProvider extends ChangeNotifier {
  List<UserModel> users = <UserModel>[
    UserModel(
      id: '1',
      name: 'mohamed',
      imgPath: userOne,
      phone: '+249929928299',
    ),
    UserModel(
      id: '2',
      name: 'syed',
      imgPath: userTow,
      phone: '+249929928299',
    ),
    UserModel(
      id: '3',
      name: 'suliman',
      imgPath: userThree,
      phone: '+249929928299',
    ),
    UserModel(
      id: '4',
      name: 'abbas',
      imgPath: userFour,
      phone: '+249929928299',
    ),
  ];
  //
  final resetUsers = <UserModel>[
    UserModel(
      id: '1',
      name: 'mohamed',
      imgPath: userOne,
      phone: '+249929928299',
    ),
    UserModel(
      id: '2',
      name: 'syed',
      imgPath: userTow,
      phone: '+249929928299',
    ),
    UserModel(
      id: '3',
      name: 'suliman',
      imgPath: userThree,
      phone: '+249929928299',
    ),
    UserModel(
      id: '4',
      name: 'abbas',
      imgPath: userFour,
      phone: '+249929928299',
    ),
  ];
  //
  late UserModel _setTagetUser;
  late UserModel _loginUser;

  UserModel get targetUser => _setTagetUser;
  UserModel get loginUser => _loginUser;
  //
  void setLoginUser(UserModel userModel) {
    _loginUser = userModel;
    debugPrint('login User = ${_loginUser.name} , id = ( ${_loginUser.id} )');
    removeUser(userModel);
    notifyListeners();
  } //

  void setTargetUser(UserModel userModel) {
    _setTagetUser = userModel;
    _setTagetUser.isOnline = true;
    debugPrint('chat user with ( ${_setTagetUser.name} )');
    notifyListeners();
  }

  void removeUser(UserModel userModel) {
    users.remove(userModel);
  }

  void getUsers() {
    users = resetUsers;
    notifyListeners();
  }

  final messageController = TextEditingController();
  //
  bool isSendIcon = false;
  //
  void validation(String value) {
    if (value.isEmpty) {
      isSendIcon = false;
    } else {
      isSendIcon = true;
    }
    notifyListeners();
  }
}
