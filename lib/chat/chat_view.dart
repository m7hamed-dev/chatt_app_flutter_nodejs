import 'package:chat_app_nodejs/chat/own_msg_cart.dart';
import 'package:chat_app_nodejs/chat_api/chat_api.dart';
import 'package:chat_app_nodejs/models/msg_model.dart';
import 'package:chat_app_nodejs/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import 'reply_msg_card.dart';

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

  //
  void setMessage(String msg, String type) {
    ChatAPIs.messages.add(MsgModel(msg: msg, type: type));
    // setState(() {});
  }

  ///
  @override
  Widget build(BuildContext context) {
    final _usersProvier = context.watch<UserProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(_usersProvier.targetUser.name),
        leading: IconButton(
          onPressed: () {
            _usersProvier.getUsers();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: ListView.builder(
        itemCount: ChatAPIs.messages.length,
        itemBuilder: (context, index) {
          //
          if (ChatAPIs.messages[index].type == 'source') {
            return OwnMsgCard(msg: ChatAPIs.messages[index].msg);
          }
          return ReplyMsgCard(msg: ChatAPIs.messages[index].msg);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setMessage('msg', 'source');
          //
          debugPrint('  login id = ${_usersProvier.loginUser.id}');
          debugPrint('--------------------------------------------');
          debugPrint('  target id = ${_usersProvier.targetUser.id}');
          debugPrint('--------------------------------------------');
          // return;
          ChatAPIs.sendMessage(
            _usersProvier.loginUser.id,
            'hi , msg',
            _usersProvier.targetUser.id,
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    ChatAPIs.disposeSocket();
  }
}
