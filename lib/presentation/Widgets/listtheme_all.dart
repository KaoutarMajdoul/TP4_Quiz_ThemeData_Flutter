
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:tp3quizfirebase/buisness_logic/bloc/theme_bloc/theme_bloc.dart';
import 'package:tp3quizfirebase/buisness_logic/cubits/answer_question_cubit.dart';
import 'package:tp3quizfirebase/buisness_logic/cubits/next_question_cubit.dart';
import 'package:tp3quizfirebase/buisness_logic/cubits/score_quiz_cubit.dart';
import 'package:tp3quizfirebase/data/models/theme_model.dart';
import 'package:tp3quizfirebase/presentation/pages/quiz.dart';

class ThematiqueItemContainer extends StatelessWidget {
  const ThematiqueItemContainer({
    Key? key, required this.state, required this.index,
  }) : super(key: key);

  final ThemeLoaded state;
  final int index;
  

  @override
  Widget build(BuildContext context) {
        void resetCubit(BuildContext c) {
      c.read<NextQuestionCubit>().reset();
      c.read<ScoreQuizCubit>().reset();
      c.read<AnswerQuestionCubit>().reset();
    }
    return InkWell(
      // bouton sur le container
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => QuizPage(
                    theme: state.getThemes.elementAt(index)
                        as ThemeQuiz,
                  )),
        ).then((value) {
          resetCubit(
              context);
        });
      },

      child: Container(
          width: 200,
          margin: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(

            children: [
              Expanded(

              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(10),
                        bottom: Radius.circular(0)),
                    image: DecorationImage(
                        image: NetworkImage((state.getThemes
                            .elementAt(index)!
                            .getUrl())),
                        fit: BoxFit.cover)),
              )) ,
              Expanded(
              child: Container(
                  padding: const EdgeInsets.all(2.0),
                  child: Column(
                    children: [
                      Text(state.getThemes.elementAt(index)!.nom,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),

                    ],
                  ))
              )],
          )),
    );
  }
}
