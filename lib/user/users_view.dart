import 'package:chat_app_nodejs/chat/chat_view.dart';
import 'package:chat_app_nodejs/models/user_model.dart';
import 'package:chat_app_nodejs/providers/users_provider.dart';
import 'package:chat_app_nodejs/tools/push.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class UserView extends StatelessWidget {
  const UserView({Key? key}) : super(key: key);
  // final String targetID;

  @override
  Widget build(BuildContext context) {
    final _usersProvier = context.watch<UserProvider>();
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: List.generate(
          _usersProvier.users.length,
          (index) {
            return InkWell(
              onTap: () {
                _usersProvier.setLoginUser(_usersProvier.users[index]);
                //
                Push.to(
                  context,
                  CahtView(userID: _usersProvier.currentUser.id),
                );
              },
              child: Container(
                color: Colors.grey.shade200,
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_usersProvier.users[index].id),
                    Text(_usersProvier.users[index].name),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
