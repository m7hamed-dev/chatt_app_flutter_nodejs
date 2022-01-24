import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.child,
    this.margin,
    this.padding,
  }) : super(key: key);
  final Widget child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade50,
            spreadRadius: 5.0,
            blurRadius: 5.0,
            offset: const Offset(0.2, 2.0),
          ),
        ],
      ),
      child: child,
    );
  }
}
