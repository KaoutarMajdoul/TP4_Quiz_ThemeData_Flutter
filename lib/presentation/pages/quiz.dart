import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp3quizfirebase/buisness_logic/bloc/question_bloc/question_bloc.dart';
import 'package:tp3quizfirebase/buisness_logic/cubits/answer_question_cubit.dart';
import 'package:tp3quizfirebase/buisness_logic/cubits/next_question_cubit.dart';
import 'package:tp3quizfirebase/data/models/theme_model.dart';
//import 'package:td3_quiz_firebase/data/repositories/question_repository.dart';
import 'package:tp3quizfirebase/data/repositories/theme_repository.dart';
import 'package:tp3quizfirebase/presentation/Widgets/buttons_quiz_widget.dart';
//import 'package:td3_quiz_firebase/data/repositories/questions_repository.dart';
import 'package:tp3quizfirebase/presentation/Widgets/image_quiz_widget.dart';
import 'package:tp3quizfirebase/presentation/Widgets/progress_quiz_widget.dart';
import 'package:tp3quizfirebase/presentation/Widgets/empty_question_widget.dart';
import 'package:tp3quizfirebase/presentation/Widgets/score_quiz_widget.dart';
import 'package:tp3quizfirebase/presentation/pages/form_add_quest.dart';
import 'package:tp3quizfirebase/presentation/pages/home.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({Key? key, required this.theme}) : super(key: key);

  final ThemeQuiz theme;

  @override
  Widget build(BuildContext context) {
    final questionBloc = BlocProvider.of<QuestionBloc>(context);
    questionBloc.add(GetAllQuestionsForThematique(theme.nom));


    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz : ${theme.nom}"),
        actions: <Widget>[
          // Bouton pour aller sur la page de formulaire d'ajout d'une question
          ButtonToFormQuestionPage(theme: theme),
          // Bouton pour supprimer la thématique

        ],
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<QuestionBloc, QuestionState>(
          builder: (context, state) {
            if (state is QuestionLoading) {
              return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                    SizedBox(
                      height: 30,
                    ),
                    CircularProgressIndicator()
                  ]));
            }
            if (state is QuestionLoaded) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 20),
                    // Container for Header (score and index)
                    Container(
                        width: 250,
                        height: 50,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            IndexQuiz(), // index du jeu (numéro question en cours)
                            ScoreQuiz(), // Score du jeu
                          ],
                        )),
                    const SizedBox(height: 30),
                    // image de la thématique du quiz
                    ImageQuiz(url: theme.getUrl()),
                    const SizedBox(height: 20),

                    BlocBuilder<NextQuestionCubit, int>(
                      builder: (_, index) {
                        return BlocBuilder<AnswerQuestionCubit, int>(
                            builder: (_, answer) {
                          return Container(
                              // Container for Questions
                              width: 350,
                              height: 100,
                              padding: const EdgeInsets.all(10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 2.0,
                                    color: answer == 2
                                        ? Colors.blueGrey.shade200
                                        : (answer == 1
                                            ? Colors.green
                                            : Colors.red),
                                  )),
                              child: BlocBuilder<QuestionBloc, QuestionState>(
                                builder: (context, state) {
                                  if (state is QuestionLoading) {
                                    // Chargement
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (state is QuestionLoaded) {
                                    return Text(
                                      state.getQuestions
                                          .elementAt(index)!
                                          .question
                                          .toString(),
                                      style: const TextStyle(fontSize: 18),
                                      textAlign: TextAlign.center,
                                    );
                                  } else if (state is QuestionNotLoaded) {
                                    return const Center(
                                        child: Text("Aucune question"));
                                  }
                                  return const Center(
                                      child: Text("Aucune question"));
                                },
                              ));
                        });
                      },
                    ),
                    const SizedBox(height: 40),
                    // Les boutons vrai, faux, suivant
                    ButtonsQuiz(state: state),
                  ],
                ),
              );
            }
            // Si il n'y a pas de questions, on affiche un message et un bouton pour ajouter une question
            return NoQuestionContainer(theme: theme);
          },
        ),
      ),
    );
  }
}





class ButtonToFormQuestionPage extends StatelessWidget {
  const ButtonToFormQuestionPage({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final ThemeQuiz theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FormulaireQuestionsPage(
                      theme: theme.nom,
                    )),
          ),
          child: const Icon(
            Icons.add_circle,
            size: 26.0,
          ),
        ));
  }
}
