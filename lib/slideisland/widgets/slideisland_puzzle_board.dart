import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/serversync/bloc/serversync_bloc.dart';

abstract class _BoardSize {
  static Map<int, double> small = {
    1: 324,
    2: 424,
    3: 600,
  };

  static Map<int, double> medium = {
    1: 424,
    2: 474,
    3: 600,
  };

  static Map<int, double> large = {
    1: 474,
    2: 500,
    3: 600,
  };
}

/// {@template slideisland_puzzle_board}
/// Displays the board of the puzzle in a [Stack] filled with [tiles].
/// {@endtemplate}
class SlideIslandPuzzleBoard extends StatefulWidget {
  /// {@macro slideisland_puzzle_board}
  const SlideIslandPuzzleBoard({
    Key? key,
    required this.tiles,
  }) : super(key: key);

  /// The tiles to be displayed on the board.
  final List<Widget> tiles;

  @override
  State<SlideIslandPuzzleBoard> createState() => _SlideIslandPuzzleBoardState();
}

class _SlideIslandPuzzleBoardState extends State<SlideIslandPuzzleBoard> {
  @override
  Widget build(BuildContext context) {
    final currentRound =
        context.select((ServerSyncBloc bloc) => bloc.state.currentRound);

    return ResponsiveLayoutBuilder(
      small: (_, child) => SizedBox.square(
        key: const Key('slideisland_puzzle_board_small'),
        dimension: _BoardSize.small[currentRound],
        child: child,
      ),
      medium: (_, child) => SizedBox.square(
        key: const Key('slideisland_puzzle_board_medium'),
        dimension: _BoardSize.medium[currentRound],
        child: child,
      ),
      large: (_, child) => SizedBox.square(
        key: const Key('slideisland_puzzle_board_large'),
        dimension: _BoardSize.large[currentRound],
        child: child,
      ),
      child: (_) => Stack(children: widget.tiles),
    );
  }
}
