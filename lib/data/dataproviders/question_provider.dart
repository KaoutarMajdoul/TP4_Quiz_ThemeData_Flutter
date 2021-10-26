import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tp3quizfirebase/data/models/question_model.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;


class QuestionProvider {


  static CollectionReference getGroupCollection() {
    return firestore.collection('questions');
  }


  Query getAllQuestions() {
    return QuestionProvider.getGroupCollection().withConverter<Question>(
      fromFirestore: (snapshot, _) => Question.fromJson(snapshot.data()!),
      toFirestore: (question, _) => question.toJson(),
    );
  }
  Future<DocumentSnapshot<Object?>> getQuestion(String id) {
    return QuestionProvider.getGroupCollection().doc(id).get();
  }
  Future<void> addQuestion(Question newQuestion) async {
    return QuestionProvider.getGroupCollection()
        .doc()
        .set(newQuestion.toJson());
  }
  Query getAllQuestionsByThematique(String theme) {
    return QuestionProvider.getGroupCollection()
        .where("theme", isEqualTo: theme).withConverter<Question>(
      fromFirestore: (snapshot, _) => Question.fromJson(snapshot.data()!),
      toFirestore: (question, _) => question.toJson(),
    );
  }


}
