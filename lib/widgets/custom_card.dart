import 'package:chat_app_nodejs/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.child,
    this.margin,
    this.padding,
    this.height,
  }) : super(key: key);
  final Widget child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? height;
  @override
  Widget build(BuildContext context) {
    final _settingProvider = context.watch<SettingsProvider>();
    return Container(
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: _settingProvider.isDark ? Colors.grey : Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: _settingProvider.isDark
                ? Colors.grey.shade100
                : Colors.grey.shade50,
            spreadRadius: 0.0,
            blurRadius: 0.0,
            offset: const Offset(0.2, 2.0),
          ),
        ],
      ),
      child: child,
    );
  }
}
