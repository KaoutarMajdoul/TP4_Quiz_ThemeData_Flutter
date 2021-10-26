import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'package:tp3quizfirebase/buisness_logic/bloc/question_bloc/question_bloc.dart';
import 'package:tp3quizfirebase/buisness_logic/cubits/answer_question_cubit.dart';
import 'package:tp3quizfirebase/buisness_logic/cubits/next_question_cubit.dart';
import 'package:tp3quizfirebase/buisness_logic/cubits/score_quiz_cubit.dart';
import 'package:tp3quizfirebase/data/repositories/question_repository.dart';
import 'package:tp3quizfirebase/presentation/pages/home.dart';

import 'buisness_logic/bloc/theme_bloc/theme_bloc.dart';
import 'buisness_logic/cubits/theme_cubit.dart';
import 'data/repositories/theme_repository.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NextQuestionCubit>(
          create: (BuildContext context) => NextQuestionCubit(),
        ),
        BlocProvider<ScoreQuizCubit>(
          create: (BuildContext context) => ScoreQuizCubit(),
        ),
        BlocProvider<AnswerQuestionCubit>(
          create: (BuildContext context) => AnswerQuestionCubit(),
        ),
        BlocProvider<ThemeCubit>(
          create: (BuildContext context) => ThemeCubit(),
        ),
        BlocProvider<ThemeBloc>(
          create: (BuildContext context) => ThemeBloc(ThemeRepository()),
        ),

      ],
      child: BlocBuilder<ThemeCubit, bool>(
        builder: (context, state) {
          return MaterialApp(
            themeMode: state ? ThemeMode.dark : ThemeMode.light,
            darkTheme: ThemeData.dark(),

            title: 'Questions/Réponses',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blueGrey,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),

            home: const HomePage(title: "QuizApp"),


          );
        },
      ),


    );
  }
}
