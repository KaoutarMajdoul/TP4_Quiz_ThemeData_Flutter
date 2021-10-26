import 'package:flutter_bloc/flutter_bloc.dart';

class AnswerQuestionCubit extends Cubit<int>{
  AnswerQuestionCubit() : super(2);

  void correct() => emit(1);
  void incorrect() => emit(0);
  void reset() => emit(2);
  
}