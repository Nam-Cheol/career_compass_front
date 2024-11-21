import 'package:equatable/equatable.dart';

class UserSendConversation extends Equatable {
  int id;
  int user;
  int numberOfQuestions;
  String question;
  String? summation;

  UserSendConversation({
    required this.id,
    required this.user,
    required this.numberOfQuestions,
    required this.question,
    this.summation
  });

  UserSendConversation.fromJson(Map<String, dynamic> json) :
      id = json['id'],
      user = json['user'],
      numberOfQuestions = json['numberOfQuestions'],
      question = json['question'],
      summation = json['summation'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'numberOfQuestions': numberOfQuestions,
      'question': question,
      'summation': summation,
    };
  }

  @override
  List<Object?> get props => [id, user, numberOfQuestions, question, summation];
}
