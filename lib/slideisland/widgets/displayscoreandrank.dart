// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';
import 'package:very_good_slide_puzzle/typography/typography.dart';

class DisplayScoreAndRank extends StatelessWidget {
  const DisplayScoreAndRank({
    Key? key,
    required this.score,
    required this.rank,
    required this.players,
    required this.playersMovingOn,
    this.color,
  }) : super(key: key);

  final int score;
  final int rank;
  final int players;
  final int playersMovingOn;

  /// Defaults to [PuzzleTheme.defaultColor].
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    const textColor = PuzzleColors.black;

    return ResponsiveLayoutBuilder(
      small: (context, child) => Center(child: child),
      medium: (context, child) => Center(child: child),
      large: (context, child) => child!,
      child: (currentSize) {
        final mainAxisAlignment = currentSize == ResponsiveLayoutSize.large
            ? MainAxisAlignment.start
            : MainAxisAlignment.center;

        final bodyTextStyle = currentSize == ResponsiveLayoutSize.small
            ? PuzzleTextStyle.bodySmall
            : PuzzleTextStyle.body;

        return Semantics(
          label: l10n.puzzleDisplayScoreAndRankLabelText(
            score.toString(),
            rank.toString(),
          ),
          child: ExcludeSemantics(
            child: Column(
              children: [
                Row(
                  key: const Key('display_score_and_rank'),
                  mainAxisAlignment: mainAxisAlignment,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    AnimatedDefaultTextStyle(
                      key: const Key('display_score_and_rank_moves'),
                      style: PuzzleTextStyle.headline4.copyWith(
                        color: textColor,
                      ),
                      duration: PuzzleThemeAnimationDuration.textStyle,
                      child: Text(score.toString()),
                    ),
                    AnimatedDefaultTextStyle(
                      style: bodyTextStyle.copyWith(
                        color: textColor,
                      ),
                      duration: PuzzleThemeAnimationDuration.textStyle,
                      child: Text(' ${l10n.puzzleScore} | '),
                    ),
                    AnimatedDefaultTextStyle(
                      key: const Key('display_score_and_rank_tiles_left'),
                      style: PuzzleTextStyle.headline4.copyWith(
                        color: textColor,
                      ),
                      duration: PuzzleThemeAnimationDuration.textStyle,
                      child: Text('$rank / $players'),
                    ),
                    AnimatedDefaultTextStyle(
                      style: bodyTextStyle.copyWith(
                        color: textColor,
                      ),
                      duration: PuzzleThemeAnimationDuration.textStyle,
                      child: Text(' ${l10n.puzzleRank}'),
                    ),
                  ],
                ),
                Row(
                  key: const Key('display_player_position'),
                  mainAxisAlignment: mainAxisAlignment,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: const [
                    // SlideIslandPlayerPosition(),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
