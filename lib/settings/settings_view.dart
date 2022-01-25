import 'package:chat_app_nodejs/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _settingProvider = context.watch<SettingsProvider>();
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Switch(
            value: _settingProvider.isDark,
            onChanged: (val) {
              _settingProvider.changeTheme();
            },
          ),
        ],
      ),
    );
  }
}
