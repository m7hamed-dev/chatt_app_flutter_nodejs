import 'package:chat_app_nodejs/chat/chat_view.dart';
import 'package:chat_app_nodejs/user/users_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth/login_view.dart';
import 'providers/users_provider.dart';

void main() {
  // Dart client

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
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
      title: 'Flutter Chat - App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const LoginView(),
    );
  }
}
