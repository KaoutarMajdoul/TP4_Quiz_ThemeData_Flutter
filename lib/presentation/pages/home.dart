import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp3quizfirebase/buisness_logic/bloc/theme_bloc/theme_bloc.dart';
import 'package:tp3quizfirebase/presentation/Widgets/listtheme_all.dart';
import 'package:tp3quizfirebase/presentation/pages/form_add_theme.dart';
import 'package:tp3quizfirebase/buisness_logic/cubits/theme_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
    themeBloc.add(GetAllThemes());
    create:(context) => ThemeCubit();

    return BlocBuilder<ThemeCubit, bool>(
  builder: (context, state) {
    return Scaffold(

      appBar: AppBar(
        title: Text(title),


        automaticallyImplyLeading: false,
        actions: <Widget>[

          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        const FormulaireThemePage(title: 'Nouveau theme',)),
                  );
                },
                child: const Icon(
                  Icons.add_circle,
                  size: 20.0,
                ),
              )),
          BlocBuilder<ThemeCubit, bool>(
            builder: (context, state) {
              return Switch(value: state, onChanged: (value) { BlocProvider.of<ThemeCubit>(context).toggleTheme(value: value);});
            },
          ),

        ],
      ),
      body: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          if (state is ThemeLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ThemeLoaded) {
            return ListView.builder(
                padding: const EdgeInsets.all(8.0),
                reverse: false,
                itemCount: state.getThemes.length,
                itemBuilder: (_, int index) {
                  return ThematiqueItemContainer(state: state, index: index);
                });
          } else {
            return const Center(child: Text("Aucun theme."));
          }
        },
      ),
    );
  },
);
  }
}

