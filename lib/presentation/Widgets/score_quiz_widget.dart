
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp3quizfirebase/buisness_logic/cubits/score_quiz_cubit.dart';

class ScoreQuiz extends StatelessWidget {
  const ScoreQuiz({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScoreQuizCubit, int>(
      builder: (_, score) {
        return Center(
            child: Text('$score point(s)',
                style: const TextStyle(fontSize: 15)));
      },
    );
  }
}

