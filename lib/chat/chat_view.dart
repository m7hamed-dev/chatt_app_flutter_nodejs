import 'dart:io';

import 'package:chat_app_nodejs/chat/own_msg_cart.dart';
import 'package:chat_app_nodejs/chat_api/chat_api.dart';
import 'package:chat_app_nodejs/providers/users_provider.dart';
import 'package:chat_app_nodejs/style/custom_theme.dart';
import 'package:chat_app_nodejs/widgets/cached_img.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import 'reply_msg_card.dart';

class CahtView extends StatefulWidget {
  const CahtView({Key? key, required this.userID}) : super(key: key);
  final String userID;
  @override
  State<CahtView> createState() => _CahtViewState();
}

class _CahtViewState extends State<CahtView>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    ChatAPIs().initializeSocket();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
  }

  //
  // void setMessage(String msg, String type) {
  //   ChatAPIs().messages.add(MsgModel(msg: msg, type: type));
  //   // setState(() {});
  // }

  late AnimationController _animationController;
  bool emojiShowing = false;
  final TextEditingController _controller = TextEditingController();
  _onEmojiSelected(Emoji emoji) {
    _controller
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
  }

  _onBackspacePressed() {
    _controller
      ..text = _controller.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
  }

  ///
  @override
  Widget build(BuildContext context) {
    final _usersProvier = context.watch<UserProvider>();
    final _chatProvier = context.watch<ChatAPIs>();
    debugPrint('ChatAPIs.messages = ${_chatProvier.messages.length}');
    return Scaffold(
      appBar: AppBar(
        title: _targetUserCard(_usersProvier, context),
        leading: IconButton(
          onPressed: () {
            _usersProvier.getUsers();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: ListView.builder(
              itemCount: _chatProvier.messages.length,
              itemBuilder: (context, index) {
                //
                if (_chatProvier.messages[index].type == 'source') {
                  return OwnMsgCard(msg: _chatProvier.messages[index].msg);
                }
                return ReplyMsgCard(msg: _chatProvier.messages[index].msg);
              },
            ),
          ),
          // bottom send
          Positioned(
            bottom: 20.0,
            left: 10,
            right: 10,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    autocorrect: true,
                    controller: _usersProvier.messageController,
                    onChanged: (value) {
                      _usersProvier.validation(value);
                      _handleOnPressed(_usersProvier);
                    },
                    decoration: const InputDecoration(
                      hintText: 'Type Your Message Here...',
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white70,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Colors.red, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      emojiShowing = !emojiShowing;
                    });
                  },
                  icon: const Icon(Icons.emoji_emotions_rounded),
                ),
                Offstage(
                  offstage: !emojiShowing,
                  child: SizedBox(
                    height: 250,
                    child: EmojiPicker(
                      onEmojiSelected: (Category category, Emoji emoji) {
                        _onEmojiSelected(emoji);
                      },
                      onBackspacePressed: _onBackspacePressed,
                      config: Config(
                        columns: 7,
                        // Issue: https://github.com/flutter/flutter/issues/28894
                        emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                        verticalSpacing: 0,
                        horizontalSpacing: 0,
                        initCategory: Category.RECENT,
                        bgColor: const Color(0xFFF2F2F2),
                        indicatorColor: Colors.blue,
                        iconColor: Colors.grey,
                        iconColorSelected: Colors.blue,
                        progressIndicatorColor: Colors.blue,
                        backspaceColor: Colors.blue,
                        showRecentsTab: true,
                        recentsLimit: 28,
                        noRecentsText: 'No Recents',
                        noRecentsStyle: const TextStyle(
                            fontSize: 20, color: Colors.black26),
                        tabIndicatorAnimDuration: kTabScrollDuration,
                        categoryIcons: const CategoryIcons(),
                        buttonMode: ButtonMode.MATERIAL,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    // setMessage(msg, type);
                    //
                    _chatProvier.sendMessage(
                      _usersProvier.loginUser.id,
                      _usersProvier.messageController.text,
                      _usersProvier.targetUser.id,
                    );
                    _usersProvier.messageController.clear();
                    debugPrint('length = ${_chatProvier.messages.length}');
                  },
                  icon: AnimatedIcon(
                    icon: AnimatedIcons.play_pause,
                    progress: _animationController,
                  ),
                )
              ],
            ),
          )
        ],
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setMessage('msg', 'source');
      //     //
      //     debugPrint('  login id = ${_usersProvier.loginUser.id}');
      //     debugPrint('--------------------------------------------');
      //     debugPrint('  target id = ${_usersProvier.targetUser.id}');
      //     debugPrint('--------------------------------------------');
      //     // return;
      //     ChatAPIs.sendMessage(
      //       _usersProvier.loginUser.id,
      //       'hi , msg',
      //       _usersProvier.targetUser.id,
      //     );
      //   },
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }

  Row _targetUserCard(UserProvider _usersProvier, BuildContext context) {
    return Row(
      children: [
        CachedImg(imageUrl: _usersProvier.targetUser.imgPath),
        const SizedBox(width: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _usersProvier.targetUser.name,
              style: CustomTheme.customfontTheme(context,
                  color: Colors.white, fontSize: 20.0),
            ),
            const SizedBox(height: 5.0),
            Text(
              _usersProvier.targetUser.isOnline == null ? 'online' : 'offline',
              style: CustomTheme.customfontTheme(
                context,
                color: _usersProvier.targetUser.isOnline == null
                    ? Colors.black
                    : Colors.black,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _handleOnPressed(UserProvider userProvider) {
    // userProvider.isSendIcon = !userProvider.isSendIcon;
    //
    userProvider.isSendIcon
        ? _animationController.forward()
        : _animationController.reverse();
  }
}
