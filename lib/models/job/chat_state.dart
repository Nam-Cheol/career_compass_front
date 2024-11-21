// lib/models/job/chat_state.dart

import 'package:equatable/equatable.dart';
import 'chat_message.dart';

class ChatState extends Equatable {
  final List<ChatMessage> messages;
  final bool isLoading;
  final String? error;
  final bool result;

  ChatState({
    required this.messages,
    required this.isLoading,
    this.error,
    required this.result
  });

  factory ChatState.initial() {
    return ChatState(
      messages: [],
      isLoading: false,
      error: null,
      result: false,
    );
  }

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    String? error,
    bool? result,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error, // null이 전달될 경우 기존 값 유지
      result: result ?? this.result,
    );
  }

  @override
  List<Object?> get props => [messages, isLoading, error, result];
}
