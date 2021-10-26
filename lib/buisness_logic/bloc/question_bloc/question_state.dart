part of 'question_bloc.dart';

@immutable
abstract class QuestionState {}

class QuestionInitial extends QuestionState {
  @override
  String toString() => 'QuestionInitial';
}


class QuestionLoading extends QuestionState {
  @override
  String toString() => 'QuestionLoading';
}

// ignore: must_be_immutable
class QuestionLoaded extends QuestionState {
  List<Question?> questions = [];

  QuestionLoaded(this.questions);

  List<Question?> get getQuestions => questions;

  List<Object> get props => [questions];

  @override
  String toString() => 'QuestionLoaded';
}

class QuestionNotLoaded extends QuestionState {
  @override
  String toString() => 'QuestionNotLoaded';
}
