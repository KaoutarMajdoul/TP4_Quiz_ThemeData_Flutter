import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tp3quizfirebase/data/models/theme_model.dart';
import 'package:tp3quizfirebase/presentation/pages/form_add_quest.dart';

class NoQuestionContainer extends StatelessWidget {
  const NoQuestionContainer({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final ThemeQuiz theme;

  @override
  Widget build(BuildContext context) {
    return Center(

        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: <Widget>[
              Container(

                child: Image.network(theme.getUrl(), fit: BoxFit.fill,),
                width: MediaQuery.of(context).size.width,
              ),
          const SizedBox(

            height: 50,
          ),
          const Text("Ajoutez une question pour commencer ! "),

          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                // on va sur le formulaire ajout de question
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FormulaireQuestionsPage(
                            theme: theme.nom,
                          )),
                );
              },

              child: const Text("Ajouter une question")),
        ]));
  }
}
