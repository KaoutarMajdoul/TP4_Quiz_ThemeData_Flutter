class ThemeQuiz {
  final String nom;
  final String url;

  ThemeQuiz({
    required this.nom,
    required this.url,
  });

  Map<String, dynamic> toJson() => _thematiqueToJson(this);

  String getUrl() {
    return url != "" ? url : "https://media.istockphoto.com/vectors/quiz-logo-with-speech-bubble-symbols-concept-of-questionnaire-show-vector-id1140838166?k=20&m=1140838166&s=170667a&w=0&h=5b2h_inmqgU-5zPGzD_kXtJpD0MYvuVZSqxe4Q-siNY=";
  }

  ThemeQuiz.fromJson(Map<String, dynamic> json)
      : this(
          nom: json["nom"] as String,
          url: json["url"] as String,
        );

  @override
  String toString() => "Theme: $nom -> ($url)";

  Map<String, dynamic> _thematiqueToJson(ThemeQuiz instance) =>
      <String, dynamic>{
        'nom': instance.nom,
        'url': instance.url,
      };
}
