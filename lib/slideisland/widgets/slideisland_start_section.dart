import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/serversync/bloc/serversync_bloc.dart';
import 'package:very_good_slide_puzzle/slideisland/slideisland.dart';
import 'package:very_good_slide_puzzle/slideisland/widgets/displayscoreandrank.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';

/// {@template slideisland_start_section}
/// Displays the start section of the puzzle based on [state].
/// {@endtemplate}
class SlideIslandStartSection extends StatelessWidget {
  /// {@macro slideisland_start_section}
  const SlideIslandStartSection({
    Key? key,
    required this.state,
  }) : super(key: key);

  /// The state of the puzzle.
  final PuzzleState state;

  @override
  Widget build(BuildContext context) {
    final serverState = context.select((ServerSyncBloc bloc) => bloc.state);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PuzzleName(
          key: puzzleNameKey,
        ),
        PuzzleTitle(
          key: puzzleTitleKey,
          title: context.l10n.puzzleChallengeTitle,
        ),
        const ResponsiveGap(
          small: 12,
          medium: 16,
          large: 32,
        ),
        DisplayScoreAndRank(
          key: numberOfMovesAndTilesLeftKey,
          score: state.numberOfCorrectTiles,
          rank: serverState.playerRank,
          players: serverState.playersConnected,
          playersMovingOn: serverState.playersToMoveOn,
        ),
        const ResponsiveGap(
          small: 8,
          medium: 18,
          large: 32,
        ),
        ResponsiveLayoutBuilder(
          small: (_, __) => const SlideIslandTimer(),
          medium: (_, __) => const SlideIslandTimer(),
          large: (_, __) => const SizedBox(),
        ),
      ],
    );
  }
}
