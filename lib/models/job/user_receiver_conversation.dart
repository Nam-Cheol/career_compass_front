import 'package:equatable/equatable.dart';

class UserReceiverConversation extends Equatable {
  int id;
  int user;
  int numberOfQuestions;
  String answer;
  String summation;
  String finalSummation;
  String resultJob;

  UserReceiverConversation({
    required this.id,
    required this.user,
    required this.numberOfQuestions,
    required this.answer,
    required this.summation,
    required this.finalSummation,
    required this.resultJob
  });

  UserReceiverConversation.fromJson(Map<String, dynamic> json) :
        id = json['id'],
        user = json['user'],
        numberOfQuestions = json['numberOfQuestions'],
        answer = json['answer'],
        summation = json['summation'],
        finalSummation = json['finalSummation'],
        resultJob = json['resultJob'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'numberOfQuestions': numberOfQuestions,
      'answer': answer,
      'summation': summation,
      'finalSummation': finalSummation,
      'resultJob': resultJob,
    };
  }

  @override
  List<Object?> get props => [id, user, numberOfQuestions, answer, summation, finalSummation, resultJob];
}