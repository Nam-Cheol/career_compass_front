class ChatMessage {
  final String text;
  final bool isUser;
  final bool isAnimated;

  ChatMessage({
    required this.text,
    required this.isUser,
    this.isAnimated = false,
  });
}