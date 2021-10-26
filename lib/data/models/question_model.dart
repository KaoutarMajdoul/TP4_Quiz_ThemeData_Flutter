// ignore_for_file: file_names
class Question {
  final String question;
  final String theme;
  final bool isCorrect;

  Question({ required this.isCorrect, required this.question, required this.theme,});


  bool valid(bool answ) {
    return answ == isCorrect;
  }

  Map<String, dynamic> toJson() => _questionToJson(this);

  Question.fromJson(Map<String, dynamic> json)
      : this(
          question: json["question"] as String,
          isCorrect: json["isCorrect"] as bool,
          theme: json["theme"] as String,
        );

  @override
  String toString() => "Question: $question -> ($isCorrect) : $theme";

  Map<String, dynamic> _questionToJson(Question instance) => <String, dynamic>{
        'question': instance.question,
        'isCorrect': instance.isCorrect,
        'theme' : instance.theme
      };
}
