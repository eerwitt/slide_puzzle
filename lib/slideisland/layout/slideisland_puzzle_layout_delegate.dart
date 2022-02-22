import 'package:flutter/material.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/slideisland/slideisland.dart';

/// {@template slideisland_puzzle_layout_delegate}
/// A delegate for computing the layout of the puzzle UI
/// that uses a [SlideIslandTheme].
/// {@endtemplate}
class SlideIslandPuzzleLayoutDelegate extends PuzzleLayoutDelegate {
  /// {@macro slideisland_puzzle_layout_delegate}
  const SlideIslandPuzzleLayoutDelegate();

  @override
  Widget startSectionBuilder(PuzzleState state) {
    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, child) => child!,
      large: (_, child) => Padding(
        padding: const EdgeInsets.only(left: 50, right: 32),
        child: child,
      ),
      child: (_) => SlideIslandStartSection(
        state: state,
      ),
    );
  }

  @override
  Widget endSectionBuilder(PuzzleState state) {
    return Column();
  }

  @override
  Widget backgroundBuilder(PuzzleState state) {
    return const SizedBox();
  }

  @override
  Widget boardBuilder(int size, List<Widget> tiles) {
    return SlideIslandPuzzleBoard(tiles: tiles);
  }

  @override
  Widget tileBuilder(Tile tile, PuzzleState state) {
    return SlideIslandPuzzleTile(
      tile: tile,
      state: state,
    );
  }

  @override
  Widget whitespaceTileBuilder() {
    return const SizedBox();
  }

  @override
  List<Object?> get props => [];
}
