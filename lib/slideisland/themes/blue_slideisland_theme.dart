import 'package:flutter/material.dart';
import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/slideisland/slideisland.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';

/// {@template blue_slideisland_theme}
/// The blue slideisland puzzle theme.
/// {@endtemplate}
class BlueSlideIslandTheme extends SlideIslandTheme {
  /// {@macro blue_slideisland_theme}
  const BlueSlideIslandTheme() : super();

  @override
  String semanticsLabel(BuildContext context) =>
      context.l10n.slideislandBlueDashLabelText;

  @override
  Color get backgroundColor => PuzzleColors.bluePrimary;

  @override
  Color get defaultColor => PuzzleColors.blue90;

  @override
  Color get buttonColor => PuzzleColors.blue50;

  @override
  Color get menuInactiveColor => PuzzleColors.blue50;

  @override
  Color get countdownColor => PuzzleColors.blue50;

  @override
  String get themeAsset => 'assets/images/slideisland/gallery/blue.png';

  @override
  String get successThemeAsset => 'assets/images/slideisland/success/blue.png';

  @override
  String get audioControlOffAsset =>
      'assets/images/audio_control/blue_slideisland_off.png';

  @override
  String get audioAsset => 'assets/audio/dumbbell.mp3';

  @override
  String get dashAssetsDirectory => 'assets/images/slideisland/blue';
}
