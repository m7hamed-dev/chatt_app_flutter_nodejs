import 'package:chat_app_nodejs/auth/login_view.dart';
import 'package:chat_app_nodejs/providers/users_provider.dart';
import 'package:chat_app_nodejs/style/custom_theme.dart';
import 'package:chat_app_nodejs/tools/push.dart';
import 'package:flutter/material.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  void initState() {
    super.initState();
    _nextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 10.0,
              left: 10,
              child: Image.network(userOne),
            ),
            Positioned(
              // top: 90.0,
              left: 2.0,
              child: Image.network(
                userThree,
                width: 120.0,
                height: 120.0,
              ),
            ),
            Positioned(
              top: 90.0,
              right: 2.0,
              child: Image.network(
                userThree,
                width: 120.0,
                height: 120.0,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome TO ',
                    style: CustomTheme.customfontTheme(
                      context,
                      color: Colors.black,
                      fontSize: 30.0,
                    ),
                  ),
                  Text(
                    'Welcome TO ',
                    style: CustomTheme.customfontTheme(
                      context,
                      color: Colors.grey,
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const CircularProgressIndicator(
                    strokeWidth: 5.0,
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 10.0,
              right: 10,
              child: Image.network(userFour),
            ),
          ],
        ),
      ),
    );
  }

  void _nextPage() async {
    await Future.delayed(const Duration(milliseconds: 2500));
    Push.toAndClose(context, const LoginView());
  }
}
