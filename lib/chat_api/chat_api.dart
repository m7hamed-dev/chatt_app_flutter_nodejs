import 'package:provider/src/provider.dart';
import 'package:chat_app_nodejs/models/msg_model.dart';
import 'package:chat_app_nodejs/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ChatAPIs {
  // define socket io
  static io.Socket socket =
      io.io("http://192.168.121.225:5000", <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": false,
  });
  // final String ipAddress = '192.168.133.225';
  static List<MsgModel> messages = <MsgModel>[];

  static void initializeSocket(BuildContext context) {
    final _userProvider = context.read<UserProvider>();
    try {
      socket.connect();
      // event on connect success
      socket.onConnect((_) {
        debugPrint('onConnect');
        //
        socket.on("message", (data) {
          final _msgModel = MsgModel(msg: 'sss', type: 'destnation');
          messages.add(_msgModel);
          sendMessage(
              _userProvider.loginUser.id, 'sss', _userProvider.currentUser.id);
        });
      });
      //
      socket.onError((error) {
        debugPrint('error = $error');
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // login user
  static void signInUserInSocket(String userID) {
    // first login user by id
    socket.emit("signIn", userID);
  }

  // send msg
  static void sendMessage(String userID, String msg, String targetID) {
    // first login user by id
    socket.emit("message", {
      "id": userID,
      "message": msg,
      "targetId": targetID,
      "sentAt": DateTime.now().toLocal().toString().substring(0, 16),
    });
  }
}
