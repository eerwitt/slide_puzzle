// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/slideisland/slideisland.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';

/// {@template slideisland_theme}
/// The slideisland puzzle theme.
/// {@endtemplate}
abstract class SlideIslandTheme extends PuzzleTheme {
  /// {@macro slideisland_theme}
  const SlideIslandTheme() : super();

  @override
  String get name => 'SlideIsland';

  @override
  String get audioControlOnAsset =>
      'assets/images/audio_control/slideisland_on.png';

  @override
  bool get hasTimer => false;

  @override
  Color get nameColor => PuzzleColors.black;

  @override
  Color get titleColor => PuzzleColors.black;

  @override
  Color get hoverColor => PuzzleColors.black2;

  @override
  Color get pressedColor => PuzzleColors.white2;

  @override
  bool get isLogoColored => true;

  @override
  Color get menuActiveColor => PuzzleColors.white;

  @override
  Color get menuUnderlineColor => PuzzleColors.grey1;

  @override
  PuzzleLayoutDelegate get layoutDelegate =>
      const SlideIslandPuzzleLayoutDelegate();

  /// The semantics label of this theme.
  String semanticsLabel(BuildContext context);

  /// The text color of the countdown timer.
  Color get countdownColor;

  /// The path to the image asset of this theme.
  ///
  /// This asset is shown in the SlideIsland theme picker.
  String get themeAsset;

  /// The path to the success image asset of this theme.
  ///
  /// This asset is shown in the success state of the SlideIsland puzzle.
  String get successThemeAsset;

  /// The path to the audio asset of this theme.
  String get audioAsset;

  /// The path to the directory with dash assets for all puzzle tiles.
  String get dashAssetsDirectory;

  /// The path to the dash asset for the given [tile].
  ///
  /// The puzzle consists of 15 Dash tiles which correct board positions
  /// are as follows:
  ///
  ///  1   2   3   4
  ///  5   6   7   8
  ///  9  10  11  12
  /// 13  14  15
  ///
  /// The dash asset for the i-th tile may be found in the file i.png.
  String dashAssetForTile(int currentRound, Tile tile) =>
      p.join(dashAssetsDirectory, '$currentRound-${tile.value.toString()}.png');

  String assetForRoundComplete(int currentRound) =>
      p.join(dashAssetsDirectory, '$currentRound-complete.png');

  @override
  List<Object?> get props => [
        name,
        hasTimer,
        nameColor,
        titleColor,
        backgroundColor,
        defaultColor,
        buttonColor,
        hoverColor,
        pressedColor,
        isLogoColored,
        menuActiveColor,
        menuUnderlineColor,
        menuInactiveColor,
        audioControlOnAsset,
        audioControlOffAsset,
        layoutDelegate,
        countdownColor,
        themeAsset,
        successThemeAsset,
        audioAsset,
        dashAssetsDirectory
      ];
}
