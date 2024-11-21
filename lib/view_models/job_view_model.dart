// lib/view_models/job_view_model.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/job/chat_message.dart';
import '../models/job/user_send_conversation.dart';
import '../models/job/user_receiver_conversation.dart';
import '../models/job/chat_state.dart';
import '../repository/job/job_repository.dart';
import '../providers/provider/user_provider.dart';

class JobViewModel extends StateNotifier<ChatState> {
  final JobRepository _jobRepository;
  final Ref _ref;
  int _idCounter = 0; // 메시지 ID 카운터 (임시)

  JobViewModel(this._jobRepository, this._ref) : super(ChatState.initial()) {
    _init();
  }

  Future<void> _init() async {
    final userId = _ref.read(userIdProvider)?.state; // StateProvider 사용 시 .state 필요
    if (userId != null) {
      try {
        final conversations = await _jobRepository.fetchConversations(userId);
        state = state.copyWith(messages: conversations);
      } catch (e) {
        state = state.copyWith(error: "대화 기록을 불러오는 데 실패했습니다.");
      }
    }
  }

  // 사용자가 메시지를 보낼 때 호출되는 함수
  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    // 사용자 메시지 추가 및 로딩 상태 설정
    final userMessage = ChatMessage(text: text, isUser: true);
    state = state.copyWith(
      messages: [...state.messages, userMessage],
      isLoading: true,
      error: null,
    );

    // 사용자 ID 가져오기
    final userId = _ref.read(userIdProvider)?.state;
    print('userId : $userId');

    // 질문 수 계산
    final numberOfQuestions = state.messages.where((msg) => msg.isUser).length;

    // UserSendConversation 객체 생성
    final userSendConversation = UserSendConversation(
      id: 1, // 임시 ID 할당
      user: 1, // 실제 사용자 ID로 변경
      numberOfQuestions: numberOfQuestions,
      question: text,
    );

    print('-------------------------------');
    print('userSend : $userSendConversation');
    print('-------------------------------');

    try {
      // 서버에 메시지 전송 및 AI 응답 받기
      final userReceiverConversation = await _jobRepository.sendMessageToServer(userSendConversation);

      if(userReceiverConversation.resultJob == '') {
        userReceiverConversation.resultJob = '쿠쿠루삥뽕';
      }

      // AI 응답 추가 및 로딩 상태 해제
      final aiMessage = ChatMessage(text: userReceiverConversation.answer, isUser: false);
      print('================');
      print(userReceiverConversation);
      print('================');
      state = state.copyWith(
        messages: [...state.messages, aiMessage],
        isLoading: false,
      );
    } catch (e) {
      // 에러 메시지 추가 및 로딩 상태 해제
      final errorMessage = ChatMessage(text: "에러가 발생했습니다: ${e.toString()}", isUser: false);
      state = state.copyWith(
        messages: [...state.messages, errorMessage],
        isLoading: false,
      );
    }
  }

  // 초기 메시지 삽입 함수
  void sendInitialMessage(String text) {
    final initialMessage = ChatMessage(text: text, isUser: false, isAnimated: true);
    state = state.copyWith(
      messages: [...state.messages, initialMessage],
      isLoading: false,
      error: null,
    );
  }

  // 초기화 함수 (선택 사항)
  void clearMessages() {
    state = ChatState.initial();
    _idCounter = 0;
  }
}

extension on int {
   get state => null;
}
