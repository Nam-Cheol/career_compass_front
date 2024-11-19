// lib/view/user_job_chat.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/job/chat_message.dart';
import '../models/job/chat_state.dart';
import '../providers/provider/chat_provider.dart';

class UserJobChat extends ConsumerWidget {

  final String? initialMessage;

  UserJobChat({this.initialMessage});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 채팅 상태를 Riverpod을 통해 구독
    final chatState = ref.watch(chatProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('직업 대화'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 메시지 리스트
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: chatState.messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(message: chatState.messages[index]);
              },
            ),
          ),
          // 에러 메시지 표시
          if (chatState.error != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                chatState.error!,
                style: TextStyle(color: Colors.red),
              ),
            ),
          // 입력 필드 및 전송 버튼
          ChatInputField(),
        ],
      ),
      // 로딩 인디케이터
      floatingActionButton: chatState.isLoading
          ? FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
        ),
      )
          : null,
    );
  }
}

// 개별 채팅 말풍선 위젯
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
              backgroundImage: AssetImage('assets/images/ai.png'), // AI 프로필 이미지
            ),
          SizedBox(width: 10.0),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
            decoration: BoxDecoration(
              color: message.isUser ? Colors.blueAccent : Colors.grey[300],
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Text(
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
              backgroundImage: AssetImage('assets/images/user.png'), // 사용자 프로필 이미지
            ),
        ],
      ),
    );
  }
}

// 입력 필드 및 전송 버튼 위젯
class ChatInputField extends ConsumerStatefulWidget {
  @override
  _ChatInputFieldState createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends ConsumerState<ChatInputField> {
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    // 채팅 메시지를 전송하는 Provider의 함수 호출
    ref.read(chatProvider.notifier).sendMessage(text);

    // 입력 필드 비우기
    _controller.clear();
  }

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
              controller: _controller,
              decoration: InputDecoration(
                hintText: '메시지를 입력하세요...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
              ),
              onSubmitted: (value) => _sendMessage(),
            ),
          ),
          SizedBox(width: 5.0),
          // 전송 버튼
          IconButton(
            icon: Icon(Icons.send, color: Colors.blueAccent),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}

