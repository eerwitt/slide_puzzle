// ignore_for_file: public_member_api_docs

part of 'slideisland_theme_bloc.dart';

abstract class SlideIslandThemeEvent extends Equatable {
  const SlideIslandThemeEvent();
}

class SlideIslandThemeChanged extends SlideIslandThemeEvent {
  const SlideIslandThemeChanged({required this.themeIndex});

  /// The index of the changed theme in [SlideIslandThemeState.themes].
  final int themeIndex;

  @override
  List<Object> get props => [themeIndex];
}
