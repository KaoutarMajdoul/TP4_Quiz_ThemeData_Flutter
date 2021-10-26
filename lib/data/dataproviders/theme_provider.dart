import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tp3quizfirebase/data/models/theme_model.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;


class ThemeProvider {

  // --- COLLECTION REFERENCE ---
  static CollectionReference getGroupCollection() {
    return firestore.collection('themes');
  }

  // --- GET ALL ---
  Query getAllTheme() {
    return ThemeProvider.getGroupCollection().withConverter<ThemeQuiz>(
      fromFirestore: (snapshot, _) => ThemeQuiz.fromJson(snapshot.data()!),
      toFirestore: (theme, _) => theme.toJson(),
    );
  }

  // --- GET ---
  Future<DocumentSnapshot<Object?>> getTheme(String id) {
    return ThemeProvider.getGroupCollection().doc(id).get();
  }

  // --- ADD ---
  Future<void> addTheme(ThemeQuiz newTheme) async {
    return ThemeProvider.getGroupCollection()
        .doc(newTheme.nom)
        .set(newTheme.toJson());
  }

  // --- DELETE ---
  Future<void> deleteTheme(String id) async {
    return ThemeProvider.getGroupCollection().doc(id).delete();
  }
}
