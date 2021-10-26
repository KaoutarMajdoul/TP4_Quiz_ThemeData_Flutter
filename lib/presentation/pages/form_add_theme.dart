import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp3quizfirebase/buisness_logic/bloc/theme_bloc/theme_bloc.dart';
import 'package:tp3quizfirebase/data/repositories/theme_repository.dart';
import 'package:tp3quizfirebase/presentation/pages/home.dart';

class FormulaireThemePage extends StatelessWidget {
  const FormulaireThemePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: Text(title),
        ),
        body: Container(

            alignment: Alignment.center,
            padding: const EdgeInsets.all(30.0), child: const ThemeForm()));



  }
}

// Create a Form widget.
class ThemeForm extends StatefulWidget {
  const ThemeForm({Key? key}) : super(key: key);

  @override
  ThemeFormState createState() {
    return ThemeFormState();
  }
}


class ThemeFormState extends State<ThemeForm> {

  final _formKey = GlobalKey<FormState>();

  late TextEditingController _controllerNameTheme;
  late TextEditingController _controllerURLTheme;

  @override
  void initState() {
    super.initState();
    _controllerNameTheme = TextEditingController();
    _controllerURLTheme = TextEditingController();
  }

  @override
  void dispose() {
    _controllerNameTheme.dispose();
    _controllerURLTheme.dispose();
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
            controller: _controllerNameTheme,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Nom du theme',
              labelText: 'Thème',
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Le nom du thème est vide.';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          // URL input
          TextFormField(
            controller: _controllerURLTheme,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Lien url',
              labelText: 'Image du thème (url)',
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                final ThemeRepository repository = ThemeRepository();
                repository.addTheme(
                    _controllerNameTheme.text, _controllerURLTheme.text);

                // on get tous les thèmes pour mettre à jour le bloc
                themeBloc.add(GetAllThemes());

                // on retourne à la page home
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomePage(
                            title: 'QuizApp',
                          )),
                );

                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Ajout du thème')),
                );
              }
            },
            child: const Text('Créer'),
          ),
        ],
      ),
    );
  }
}
