import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:very_good_slide_puzzle/slideisland/slideisland.dart';

part 'slideisland_theme_event.dart';
part 'slideisland_theme_state.dart';

/// {@template slideisland_theme_bloc}
/// Bloc responsible for the currently selected [SlideIslandTheme].
/// {@endtemplate}
class SlideIslandThemeBloc
    extends Bloc<SlideIslandThemeEvent, SlideIslandThemeState> {
  /// {@macro slideisland_theme_bloc}
  SlideIslandThemeBloc({required List<SlideIslandTheme> themes})
      : super(SlideIslandThemeState(themes: themes)) {
    on<SlideIslandThemeChanged>(_onSlideIslandThemeChanged);
  }

  void _onSlideIslandThemeChanged(
    SlideIslandThemeChanged event,
    Emitter<SlideIslandThemeState> emit,
  ) {
    emit(state.copyWith(theme: state.themes[event.themeIndex]));
  }
}
