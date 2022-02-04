import 'package:flutter/material.dart';
import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/slideisland/slideisland.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';

/// {@template green_slideisland_theme}
/// The green slideisland puzzle theme.
/// {@endtemplate}
class GreenSlideIslandTheme extends SlideIslandTheme {
  /// {@macro green_slideisland_theme}
  const GreenSlideIslandTheme() : super();

  @override
  String semanticsLabel(BuildContext context) =>
      context.l10n.slideislandGreenDashLabelText;

  @override
  Color get backgroundColor => PuzzleColors.greenPrimary;

  @override
  Color get defaultColor => PuzzleColors.green90;

  @override
  Color get buttonColor => PuzzleColors.green50;

  @override
  Color get menuInactiveColor => PuzzleColors.green50;

  @override
  Color get countdownColor => PuzzleColors.green50;

  @override
  String get themeAsset => 'assets/images/slideisland/gallery/green.png';

  @override
  String get successThemeAsset => 'assets/images/slideisland/success/green.png';

  @override
  String get audioControlOffAsset =>
      'assets/images/audio_control/green_slideisland_off.png';

  @override
  String get audioAsset => 'assets/audio/skateboard.mp3';

  @override
  String get dashAssetsDirectory => 'assets/images/slideisland/green';
}
