// lib/views/list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/job/chat_message.dart';
import '../providers/provider/chat_provider.dart';
import 'chat_screen.dart';

class ListScreen extends ConsumerWidget {



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(chatProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('대화 목록'),
        centerTitle: true,
      ),
      body: chatState.messages.isEmpty
          ? Center(child: Text('대화가 없습니다.'))
          : ListView.builder(
        itemCount: chatState.messages.length,
        itemBuilder: (context, index) {
          final message = chatState.messages[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(
                  message.isUser ? 'assets/images/user.png' : 'assets/images/ai.png'),
            ),
            title: Text(message.isUser ? '나' : 'AI'),
            subtitle: Text(message.text),
            trailing: message.isUser
                ? Icon(Icons.person)
                : Icon(Icons.android),
            onTap: () {
              // 대화 항목을 탭하면 해당 대화로 이동
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(initialMessage: message.text),
                ),
              );
            },
          );
        },
      ),
    );
  }

  const ListScreen();
}
