import 'package:flutter/material.dart';
import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/slideisland/slideisland.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';

/// {@template yellow_slideisland_theme}
/// The yellow slideisland puzzle theme.
/// {@endtemplate}
class YellowSlideIslandTheme extends SlideIslandTheme {
  /// {@macro yellow_slideisland_theme}
  const YellowSlideIslandTheme() : super();

  @override
  String semanticsLabel(BuildContext context) =>
      context.l10n.slideislandYellowDashLabelText;

  @override
  Color get backgroundColor => PuzzleColors.yellowPrimary;

  @override
  Color get defaultColor => PuzzleColors.yellow90;

  @override
  Color get buttonColor => PuzzleColors.yellow50;

  @override
  Color get menuInactiveColor => PuzzleColors.yellow50;

  @override
  Color get countdownColor => PuzzleColors.yellow50;

  @override
  String get themeAsset => 'assets/images/slideisland/gallery/yellow.png';

  @override
  String get successThemeAsset =>
      'assets/images/slideisland/success/yellow.png';

  @override
  String get audioControlOffAsset =>
      'assets/images/audio_control/yellow_slideisland_off.png';

  @override
  String get audioAsset => 'assets/audio/sandwich.mp3';

  @override
  String get dashAssetsDirectory => 'assets/images/slideisland/yellow';
}
