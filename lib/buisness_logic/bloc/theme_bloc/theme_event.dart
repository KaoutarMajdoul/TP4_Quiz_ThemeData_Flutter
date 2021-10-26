part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {}


class GetAllThemes extends ThemeEvent {  
  GetAllThemes();
  List<Object> get props => [];
  @override
  String toString() => 'GetAllThemes';
}
