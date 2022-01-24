import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth/login_view.dart';
import 'providers/users_provider.dart';

void main() {
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
      title: 'Chat - App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const LoginView(),
    );
  }
}
