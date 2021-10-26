import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp3quizfirebase/buisness_logic/bloc/question_bloc/question_bloc.dart';
import 'package:tp3quizfirebase/buisness_logic/cubits/next_question_cubit.dart';

class IndexQuiz extends StatelessWidget {
  const IndexQuiz({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NextQuestionCubit, int>(
      builder: (_, index) {
        return Center(
          child: BlocBuilder<QuestionBloc, QuestionState>(
            builder: (context, state) {
              if (state is QuestionLoaded) {
                return Text(
                    ' ${index + 1} / ${state.questions.length}',
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold));
              } else {
                return Container();
              }
            },
          ),
        );
      },
    );
  }
}
