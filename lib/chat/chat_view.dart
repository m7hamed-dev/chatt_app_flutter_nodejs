import 'package:chat_app_nodejs/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class CahtView extends StatefulWidget {
  const CahtView({Key? key, required this.userID}) : super(key: key);
  final String userID;
  @override
  State<CahtView> createState() => _CahtViewState();
}

class _CahtViewState extends State<CahtView> {
  @override
  void initState() {
    super.initState();
    initializeSocket();
  }

  io.Socket socket = io.io("http://192.168.127.225:5000", <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": false,
  });
  // final String ipAddress = '192.168.133.225';
  void initializeSocket() {
    // debugPrint('initializeSocket .........');
    try {
      socket.connect();
      // event on connect success
      socket.onConnect((_) {
        debugPrint('onConnect');
      });
      // first login user by id
      socket.emit("signIn", widget.userID);
      socket.onError((error) {
        debugPrint('error = $error');
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void sendMessage(String message, String targetID) {
    // second send msg
    socket.emit("message", {
      "id": widget.userID,
      "message": message,
      "username": targetID,
      "sentAt": DateTime.now().toLocal().toString().substring(0, 16),
    });
  }

  @override
  Widget build(BuildContext context) {
    final _usersProvier = context.watch<UserProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(_usersProvier.currentUser.name),
      ),
      body: ListView(
        children: const [],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          sendMessage('hi mohamed', _usersProvier.currentUser.id);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // socket.disconnect();
  }
}
