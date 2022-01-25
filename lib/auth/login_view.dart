import 'package:chat_app_nodejs/chat_api/chat_api.dart';
import 'package:chat_app_nodejs/providers/users_provider.dart';
import 'package:chat_app_nodejs/settings/settings_view.dart';
import 'package:chat_app_nodejs/style/custom_theme.dart';
import 'package:chat_app_nodejs/tools/push.dart';
import 'package:chat_app_nodejs/user_contacts/users_contacts_view.dart';
import 'package:chat_app_nodejs/widgets/cached_img.dart';
import 'package:chat_app_nodejs/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _usersProvier = context.watch<UserProvider>();
    final _chatProvier = context.watch<ChatAPIs>();
    // _apiProvider.initializeSocket();

    return Scaffold(
      appBar: AppBar(
        title: const Text('login view'),
        actions: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Push.to(context, const SettingsView());
            },
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login AS',
              style: CustomTheme.customfontTheme(context, fontSize: 26.0),
            ),
            const SizedBox(height: 50.0),
            Expanded(
              child: ListView.builder(
                itemCount: _usersProvier.users.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      _chatProvier
                          .signInUserInSocket(_usersProvier.users[index].id);
                      //
                      _usersProvier.setLoginUser(_usersProvier.users[index]);
                      Push.to(context, const UserContactsView());
                    },
                    child: CustomCard(
                      margin: const EdgeInsets.all(10.0),
                      padding: const EdgeInsets.only(left: 10.0),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CachedImg(
                            imageUrl: _usersProvier.users[index].imgPath),
                        title: Text(
                          _usersProvier.users[index].name,
                          style: CustomTheme.fontTheme(context),
                        ),
                        subtitle: Text(
                          _usersProvier.users[index].phone,
                          style: CustomTheme.customfontTheme(
                            context,
                            fontSize: 13.0,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
