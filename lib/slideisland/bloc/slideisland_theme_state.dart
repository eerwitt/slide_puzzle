// ignore_for_file: public_member_api_docs

part of 'slideisland_theme_bloc.dart';

class SlideIslandThemeState extends Equatable {
  const SlideIslandThemeState({
    required this.themes,
    this.theme = const GreenSlideIslandTheme(),
  });

  /// The list of all available [SlideIslandTheme]s.
  final List<SlideIslandTheme> themes;

  /// Currently selected [SlideIslandTheme].
  final SlideIslandTheme theme;

  @override
  List<Object> get props => [themes, theme];

  SlideIslandThemeState copyWith({
    List<SlideIslandTheme>? themes,
    SlideIslandTheme? theme,
  }) {
    return SlideIslandThemeState(
      themes: themes ?? this.themes,
      theme: theme ?? this.theme,
    );
  }
}
