import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tp3quizfirebase/data/dataproviders/theme_provider.dart';
import 'package:tp3quizfirebase/data/models/theme_model.dart';

class ThemeRepository {
  ThemeRepository({Key? key});
  final _themeProvider = ThemeProvider();

  Stream<QuerySnapshot> getAllTheme() =>
      _themeProvider.getAllTheme().snapshots();


  Future<List<ThemeQuiz?>> getThemeList() async {
        return _themeProvider.getAllTheme().get().then((snapshot){
          final List<ThemeQuiz?> themes = [];
          for (var doc in snapshot.docs) {
            themes.add(doc.data() as ThemeQuiz);
          }
          return themes;
        });
  }   


  Future<DocumentSnapshot> getTheme(String id) async =>
      await _themeProvider.getTheme(id);

  Future<void> addTheme(String nom, String url) async =>
      await _themeProvider.addTheme(ThemeQuiz(nom: nom, url: url));

  Future<void> deleteTheme(String id) async =>
      await _themeProvider.deleteTheme(id);

      
}
