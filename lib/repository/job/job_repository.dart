
import 'package:career_compass_front/models/job/chat_message.dart';
import 'package:career_compass_front/models/job/user_receiver_conversation.dart';
import 'package:career_compass_front/models/job/user_send_conversation.dart';

abstract class JobRepository {

  Future<UserReceiverConversation> sendMessageToServer(UserSendConversation message);

  Future<List<ChatMessage>> fetchConversations(userId);

}