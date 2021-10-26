import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp3quizfirebase/buisness_logic/bloc/theme_bloc/theme_bloc.dart';
import 'package:tp3quizfirebase/data/repositories/question_repository.dart';
import 'package:tp3quizfirebase/presentation/pages/home.dart';

class FormulaireQuestionsPage extends StatelessWidget {
  const FormulaireQuestionsPage({Key? key, required this.theme}) : super(key: key);

  final String theme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(" $theme"),
        ),
        body: Container(
            padding: const EdgeInsets.all(20.0), child:  QuestionForm(theme: theme)));
  }
}

// Create a Form widget.
class QuestionForm extends StatefulWidget {
  const QuestionForm({Key? key, required this.theme}) : super(key: key);

  final String theme;
  @override
  QuestionFormState createState() {
    return QuestionFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class QuestionFormState extends State<QuestionForm> {

  final _formKey = GlobalKey<FormState>();

  late TextEditingController _controllerQuestion;

  bool isChecked = false;
  @override
  void initState() {
    super.initState();
    _controllerQuestion = TextEditingController();
  }

  @override
  void dispose() {
    _controllerQuestion.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
    themeBloc.add(GetAllThemes());
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          // Theme input
          TextFormField(
            controller: _controllerQuestion,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Votre question',
              labelText: 'Question',
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Votre question est vide !';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 26,
            width: 30,
          ),

          Row(
            children: [
              const Text("Est correct ? "),
              Checkbox(
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value!;
                    print(isChecked);
                  });
                },),
            ],
          ),
          
          
          const SizedBox(
            height: 26,
          ),
          ElevatedButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                final QuestionRepository repository = QuestionRepository();
                repository.addQuestion(
                    _controllerQuestion.text, isChecked, widget.theme);

                // on get tous les thèmes pour mettre à jour le bloc
                themeBloc.add(GetAllThemes());

                // on retourne à la page home
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomePage(
                            title: 'Theme',
                          )),
                );

                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Question ajoutée ! ')),
                );
              }
            },
            child: const Text('Valider '),
          ),
        ],
      ),
    );
  }
}
