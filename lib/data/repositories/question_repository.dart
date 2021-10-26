import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tp3quizfirebase/data/dataproviders/question_provider.dart';
import 'package:tp3quizfirebase/data/models/question_model.dart';

class QuestionRepository {
  QuestionRepository({Key? key});
  final _questionProvider = QuestionProvider();

  Stream<QuerySnapshot> getAllQuestions() =>
      _questionProvider.getAllQuestions().snapshots();


  Stream<QuerySnapshot> getAllQuestionsByThematique(String theme) =>
      _questionProvider.getAllQuestionsByThematique(theme).snapshots();


  Future<List<Question?>> getQuestionsList() async {
        return _questionProvider.getAllQuestions().get().then((snapshot){
          final List<Question?> questions = [];
          for (var doc in snapshot.docs) {
            questions.add(doc.data() as Question);
          }
          return questions;
        });
  } 

    Future<List<Question?>> getQuestionsThematiqueList(String theme) async {
        return _questionProvider.getAllQuestionsByThematique(theme).get().then((snapshot){
          final List<Question?> questions = [];
          for (var doc in snapshot.docs) {
            questions.add(doc.data() as Question);
          }
          return questions;
        });
  } 
  


  Future<DocumentSnapshot> getQuestion(String id) async =>
      await _questionProvider.getQuestion(id);

  Future<void> addQuestion(String question, bool isCorrect, String theme) async =>
      await _questionProvider.addQuestion(Question(question: question, isCorrect: isCorrect, theme: theme));


      
}
