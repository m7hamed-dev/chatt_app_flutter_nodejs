import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    required this.isSender,
    required this.msg,
  }) : super(key: key);
  final bool isSender;
  final String msg;
  //
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(10.0),
      width: 100,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(.4),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(isSender ? 10.0 : 0.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            msg,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            DateTime.now().toLocal().toString().substring(0, 16),
            style: const TextStyle(
              fontSize: 13.0,
            ),
          ),
        ],
      ),
    );
  }
}
