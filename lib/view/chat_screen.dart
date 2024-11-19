// lib/views/chat_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/job/chat_message.dart';
import '../providers/provider/chat_provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final String? initialMessage;

  const ChatScreen({this.initialMessage});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isInitialMessageSent = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialMessage != null && !_isInitialMessageSent) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(chatProvider.notifier).sendInitialMessage(widget.initialMessage!);
        _isInitialMessageSent = true;
      });
    }
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    ref.read(chatProvider.notifier).sendMessage(text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(chatProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('AI와 대화'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: chatState.messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(message: chatState.messages[index]);
              },
            ),
          ),
          if (chatState.error != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                chatState.error!,
                style: TextStyle(color: Colors.red),
              ),
            ),
          if (chatState.isLoading)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          ChatInputField(controller: _controller, onSend: _sendMessage),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisAlignment:
        message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isUser)
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/ai.png'),
            ),
          SizedBox(width: 10.0),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
            decoration: BoxDecoration(
              color: message.isUser ? Colors.blueAccent : Colors.grey[300],
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: message.isAnimated
                ? DefaultTextStyle(
              style: TextStyle(
                color: message.isUser ? Colors.white : Colors.black87,
                fontSize: 16.0,
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    message.text,
                    speed: Duration(milliseconds: 50),
                  ),
                ],
                totalRepeatCount: 1,
                pause: Duration(milliseconds: 1000),
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
              ),
            )
                : Text(
              message.text,
              style: TextStyle(
                color: message.isUser ? Colors.white : Colors.black87,
                fontSize: 16.0,
              ),
            ),
          ),
          SizedBox(width: 10.0),
          if (message.isUser)
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/user.png'),
            ),
        ],
      ),
    );
  }
}

class ChatInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  ChatInputField({required this.controller, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
      color: Colors.white,
      child: Row(
        children: [
          // 입력 필드
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: '메시지를 입력하세요...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
              ),
              onSubmitted: (value) => onSend(),
            ),
          ),
          SizedBox(width: 5.0),
          // 전송 버튼
          IconButton(
            icon: Icon(Icons.send, color: Colors.blueAccent),
            onPressed: onSend,
          ),
        ],
      ),
    );
  }
}
