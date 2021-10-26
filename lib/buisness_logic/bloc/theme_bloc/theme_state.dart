part of 'theme_bloc.dart';

@immutable
abstract class ThemeState {}

class ThematiqueInitial extends ThemeState {}



class ThemeInitial extends ThemeState {
  @override
  String toString() => 'ThemeInitial';
}


class ThemeLoading extends ThemeState {
  @override
  String toString() => 'ThemeLoading';
}

// ignore: must_be_immutable
class ThemeLoaded extends ThemeState {
  List<ThemeQuiz?> themes = [];

  ThemeLoaded(this.themes);

  List<ThemeQuiz?> get getThemes => themes;

  List<Object> get props => [themes];

  @override
  String toString() => 'ThemeLoaded';
}

class ThemeNotLoaded extends ThemeState {
  @override
  String toString() => 'ThemeNotLoaded';
}
