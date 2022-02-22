import 'package:flutter/material.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';

abstract class _BoardSize {
  static double small = 300;
  static double medium = 400;
  static double large = 500;
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
    return ResponsiveLayoutBuilder(
      small: (_, child) => SizedBox.square(
        key: const Key('slideisland_puzzle_board_small'),
        dimension: _BoardSize.small,
        child: child,
      ),
      medium: (_, child) => SizedBox.square(
        key: const Key('slideisland_puzzle_board_medium'),
        dimension: _BoardSize.medium,
        child: child,
      ),
      large: (_, child) => SizedBox.square(
        key: const Key('slideisland_puzzle_board_large'),
        dimension: _BoardSize.large,
        child: child,
      ),
      child: (_) => Stack(children: widget.tiles),
    );
  }
}
