import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tp3quizfirebase/data/models/theme_model.dart';
import 'package:tp3quizfirebase/data/repositories/theme_repository.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeRepository repository;

  ThemeBloc(this.repository) : super(ThemeInitial());
  ThemeState get initialState => ThemeInitial();

    @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is GetAllThemes) {
      yield ThemeLoading();
      try {
        final List<ThemeQuiz?> themes = await repository.getThemeList();
        
        if(themes.isEmpty) {
          yield ThemeNotLoaded();
        } else {
          yield ThemeLoaded(themes);
        }
      } catch (error) {
        yield ThemeNotLoaded();
      }
    }
    }
}
