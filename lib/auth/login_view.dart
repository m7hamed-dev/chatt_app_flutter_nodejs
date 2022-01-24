import 'package:chat_app_nodejs/chat_api/chat_api.dart';
import 'package:chat_app_nodejs/providers/users_provider.dart';
import 'package:chat_app_nodejs/tools/push.dart';
import 'package:chat_app_nodejs/user_contacts/users_contacts_view.dart';
import 'package:chat_app_nodejs/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();
    ChatAPIs.initializeSocket();
  }

  @override
  Widget build(BuildContext context) {
    final _usersProvier = context.watch<UserProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('login view'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select Login AS : '),
            Expanded(
              child: ListView(
                children: List.generate(
                  _usersProvier.users.length,
                  (index) {
                    return InkWell(
                      onTap: () {
                        ChatAPIs.signInUserInSocket(
                            _usersProvier.users[index].id, context);
                        //
                        _usersProvier.setLoginUser(_usersProvier.users[index]);
                        Push.to(context, const UserContactsView());
                      },
                      child: CustomCard(
                        margin: const EdgeInsets.all(10.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                _usersProvier.users[index].imgPath),
                          ),
                          title: Text(_usersProvier.users[index].id),
                          subtitle: Text(_usersProvier.users[index].name),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
