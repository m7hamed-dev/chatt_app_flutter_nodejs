import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ChatAPIs {
  static io.Socket socket =
      io.io("http://192.168.121.225:5000", <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": false,
  });
  // final String ipAddress = '192.168.133.225';
  static void initializeSocket() {
    // debugPrint('initializeSocket .........');
    try {
      socket.connect();
      // event on connect success
      socket.onConnect((_) {
        debugPrint('onConnect');
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
    socket.emit("/signIn", userID);
  }

  // send msg
  static void sendMessage(String userID, String msg, String targetID) {
    // first login user by id
    socket.emit("message", {
      "id": userID,
      "message": msg,
      "username": targetID,
      "sentAt": DateTime.now().toLocal().toString().substring(0, 16),
    });
  }
}
