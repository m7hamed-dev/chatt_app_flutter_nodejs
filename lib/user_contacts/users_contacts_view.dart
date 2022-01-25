import 'package:chat_app_nodejs/chat/chat_view.dart';
import 'package:chat_app_nodejs/providers/users_provider.dart';
import 'package:chat_app_nodejs/style/custom_theme.dart';
import 'package:chat_app_nodejs/tools/push.dart';
import 'package:chat_app_nodejs/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class UserContactsView extends StatelessWidget {
  const UserContactsView({Key? key}) : super(key: key);
  // final String targetID;

  @override
  Widget build(BuildContext context) {
    final _usersProvier = context.watch<UserProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Contacts View'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Chat With :'),
            Expanded(
              child: ListView(
                children: List.generate(
                  _usersProvier.users.length,
                  (index) {
                    return InkWell(
                        onTap: () {
                          _usersProvier
                              .setTargetUser(_usersProvier.users[index]);
                          //
                          Push.to(
                            context,
                            CahtView(
                              userID: _usersProvier.targetUser.id,
                            ),
                          );
                        },
                        child: CustomCard(
                          margin: const EdgeInsets.all(10.0),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  _usersProvier.users[index].imgPath),
                            ),
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
                        ));
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
