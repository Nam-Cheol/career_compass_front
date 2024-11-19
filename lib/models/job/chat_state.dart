// lib/models/job/chat_state.dart

import 'package:equatable/equatable.dart';
import 'chat_message.dart';

class ChatState extends Equatable {
  final List<ChatMessage> messages;
  final bool isLoading;
  final String? error;

  ChatState({
    required this.messages,
    required this.isLoading,
    this.error,
  });

  factory ChatState.initial() {
    return ChatState(
      messages: [],
      isLoading: false,
      error: null,
    );
  }

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    String? error,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error, // null이 전달될 경우 기존 값 유지
    );
  }

  @override
  List<Object?> get props => [messages, isLoading, error];
}
