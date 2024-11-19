import 'package:equatable/equatable.dart';

class UserReceiverConversation extends Equatable {
  int id;
  int user;
  int numberOfQuestions;
  String answer;

  UserReceiverConversation({
    required this.id,
    required this.user,
    required this.numberOfQuestions,
    required this.answer,
  });

  UserReceiverConversation.fromJson(Map<String, dynamic> json) :
        id = json['id'],
        user = json['user'],
        numberOfQuestions = json['numberOfQuestions'],
        answer = json['answer'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'numberOfQuestions': numberOfQuestions,
      'answer': answer
    };
  }

  @override
  List<Object?> get props => [id, user, numberOfQuestions, answer];
}