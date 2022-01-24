import 'package:flutter/material.dart';

class ReplyMsgCard extends StatelessWidget {
  const ReplyMsgCard({
    Key? key,
    required this.msg,
  }) : super(key: key);
  final String msg;
  //
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(10.0),
      width: 100,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(.4),
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(12),
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
