
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp3quizfirebase/buisness_logic/bloc/question_bloc/question_bloc.dart';
import 'package:tp3quizfirebase/buisness_logic/cubits/answer_question_cubit.dart';
import 'package:tp3quizfirebase/buisness_logic/cubits/next_question_cubit.dart';
import 'package:tp3quizfirebase/buisness_logic/cubits/score_quiz_cubit.dart';

class ButtonsQuiz extends StatelessWidget {
  const ButtonsQuiz({
    Key? key, required this.state,
  }) : super(key: key);

  final QuestionLoaded state;

  void nextQuestion(BuildContext c, int index, int indexMax) {
      if (index + 1 == indexMax) {
        c.read<NextQuestionCubit>().reset();
        c.read<ScoreQuizCubit>().reset();
      } else {
        c.read<NextQuestionCubit>().next();
      }
      c.read<AnswerQuestionCubit>().reset();
    }

    void checkAnswer(BuildContext c, bool answer, bool userAnswer) {
      if (answer == userAnswer) {
        c.read<AnswerQuestionCubit>().correct();
        c.read<ScoreQuizCubit>().increment();
      } else {
        c.read<AnswerQuestionCubit>().incorrect();
        c.read<ScoreQuizCubit>().decrement();
      }
    }

  @override
  Widget build(BuildContext context) {
    return Container(
        // Container for Buttons

        width: 350,
        height: 100,

        child: BlocBuilder<NextQuestionCubit, int>(
            builder: (_, index) {
          return BlocBuilder<AnswerQuestionCubit, int>(
              builder: (_, answer) {


            return Column(


              children: [
                Expanded(

                child:ElevatedButton(


                  onPressed: answer != 2
                      ? null
                      : () => checkAnswer(
                          context,
                          state.questions
                              .elementAt(index)!
                              .isCorrect,
                          true),
                  child: const Text("Vrai",
                      style: TextStyle(fontSize: 25, color: Colors.white)),

                  style: ElevatedButton.styleFrom(
                      primary: Colors.green,

                      textStyle: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold)),
                )),
                Expanded(
                child: ElevatedButton(

                  onPressed: answer != 2
                      ? null
                      : () => checkAnswer(
                          context,
                          state.questions
                              .elementAt(index)!
                              .isCorrect,
                          false),
                  child: const Text("Faux",
                      style: TextStyle(fontSize: 25, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      textStyle: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold)),

                )),

                Expanded(
                child:ElevatedButton(
                  // si c'est la fin du quiz on reset
                  onPressed: answer == 2
                      ? null
                      : () => nextQuestion(context, index,
                          state.questions.length),
                  child: Wrap(
                    children: [
                      Text(
                          index + 1 == state.questions.length
                              ? "Recommencer"
                              : "Suivant",
                          style: const TextStyle(fontSize: 15)),

                    ],
                  ),
                ))
              ],
            );
          });
        }));
  }
}
