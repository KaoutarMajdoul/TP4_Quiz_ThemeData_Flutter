part of 'question_bloc.dart';

@immutable
abstract class QuestionEvent {}


class GetAllQuestions extends QuestionEvent {  
  GetAllQuestions();
  List<Object> get props => [];
  @override
  String toString() => 'GetAllQuestions';
}

class GetAllQuestionsForThematique extends QuestionEvent { 

  final String theme;

  GetAllQuestionsForThematique(this.theme);
  List<Object> get props => [theme];
  @override
  String toString() => 'GetAllQuestionsForThematique';
}

