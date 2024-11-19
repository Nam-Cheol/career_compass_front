import 'package:career_compass_front/models/job/chat_message.dart';
import 'package:career_compass_front/models/job/user_send_conversation.dart';
import 'package:career_compass_front/models/job/user_receiver_conversation.dart';
import 'package:career_compass_front/repository/job/job_repository.dart';
import 'package:dio/dio.dart';

class JobRepositoryImpl implements JobRepository {
  final Dio _dio;

  JobRepositoryImpl(this._dio);

  @override
  Future<UserReceiverConversation> sendMessageToServer(UserSendConversation message) async {
    try {
      // 실제 서버의 엔드포인트 URL로 변경하세요

      // POST 요청 보내기
      final response = await _dio.post('/jobs/test', data: message.toJson());

      if (response.statusCode == 200) {
        // 서버의 응답 형식에 맞게 수정하세요
        print('response data : ${response.data}');
        return UserReceiverConversation.fromJson(response.data['body']);
      } else {
        throw Exception("AI 응답을 받지 못했습니다.");
      }
    } catch (e) {
      print(e);
      throw Exception("에러가 발생했습니다.");
    }
  }

  @override
  Future<List<ChatMessage>> fetchConversations(userId) {
    throw UnimplementedError();
  }
}