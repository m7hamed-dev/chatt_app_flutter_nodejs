import 'package:chat_app_nodejs/models/msg_model.dart';
import 'package:flutter/material.dart';

class MsgProvider extends ChangeNotifier {
  List<MsgModel> messages = <MsgModel>[];
  //
  void sendMsg(MsgModel msg) {
    messages.add(msg);
    notifyListeners();
  } //

  void removeMsg(MsgModel msg) {
    messages.remove(msg);
    notifyListeners();
  }
}
