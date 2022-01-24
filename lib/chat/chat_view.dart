import 'package:chat_app_nodejs/chat/chat_bubble.dart';
import 'package:chat_app_nodejs/chat_api/chat_api.dart';
import 'package:chat_app_nodejs/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

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
    ChatAPIs.initializeSocket();
  }

  // void sendMessage(String message, String targetID) {
  //   // second send msg
  //   socket.emit("message", {
  //     "id": widget.userID,
  //     "message": message,
  //     "username": targetID,
  //     "sentAt": DateTime.now().toLocal().toString().substring(0, 16),
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final _usersProvier = context.watch<UserProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(_usersProvier.currentUser.name),
        leading: IconButton(
          onPressed: () {
            _usersProvier.getUsers();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: ListView(
        children: [
          ..._allMsgs(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // sendMessage('hi mohamed', _usersProvier.currentUser.id);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  List<ChatBubble> _allMsgs() {
    return List.generate(
        90, (index) => ChatBubble(isSender: true, msg: 'msg $index')).toList();
  }

  @override
  void dispose() {
    super.dispose();
    // socket.disconnect();
  }
}
