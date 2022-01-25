import 'package:chat_app_nodejs/models/msg_model.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ChatAPIs with ChangeNotifier {
  ChatAPIs() {
    initializeSocket();
  }
  // define socket io
  static io.Socket socket =
      io.io("http://192.168.228.225:5000", <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": false,
  });
  List<MsgModel> messages = <MsgModel>[];

  void initializeSocket() {
    try {
      socket.connect();
      // event on connect success
      socket.onConnect((_) {
        debugPrint('onConnect .......');
        socket.on("message", (data) {
          debugPrint('data = $data');
          setMessage('dest', data['message']);
        });
      });
      socket.onDisconnect((data) {
        debugPrint('onDisconnect .......');
      });
      //
      socket.onError((error) {
        debugPrint('error = $error');
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void setMessage(String type, String message) {
    MsgModel messageModel = MsgModel(type: type, msg: message);
    messages.add(messageModel);
    notifyListeners();
  }

  void signInUserInSocket(String userID) => socket.emit("signIn", userID);

  void sendMessage(String userID, String msg, String targetID) {
    socket.emit("message", {
      "id": userID,
      "message": msg,
      "targetId": targetID,
      "sentAt": DateTime.now().toLocal().toString().substring(0, 16),
    });
  }

  void disposeSocket() {
    socket.dispose();
  }
}
