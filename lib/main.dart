import 'package:chat_app_nodejs/chat_api/chat_api.dart';
import 'package:chat_app_nodejs/style/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth/login_view.dart';
import 'providers/settings_provider.dart';
import 'providers/users_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
        //
        ChangeNotifierProvider<SettingsProvider>(
            create: (_) => SettingsProvider()),
        //
        ChangeNotifierProvider<ChatAPIs>(create: (_) => ChatAPIs()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Chat - App',
        debugShowCheckedModeBanner: false,
        theme: CustomTheme.themeData(context),
        home: const LoginView()
        // home: const LoginView(),
        );
  }
}
