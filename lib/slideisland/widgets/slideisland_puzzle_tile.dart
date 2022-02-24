import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:very_good_slide_puzzle/audio_control/audio_control.dart';
import 'package:very_good_slide_puzzle/helpers/helpers.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/serversync/bloc/serversync_bloc.dart';
import 'package:very_good_slide_puzzle/slideisland/slideisland.dart';
import 'package:very_good_slide_puzzle/theme/themes/themes.dart';

/// {@template slideisland_puzzle_tile}
/// Displays the puzzle tile associated with [tile]
/// based on the puzzle [state].
/// {@endtemplate}
class SlideIslandPuzzleTile extends StatefulWidget {
  /// {@macro slideisland_puzzle_tile}
  const SlideIslandPuzzleTile({
    Key? key,
    required this.tile,
    required this.state,
    AudioPlayerFactory? audioPlayer,
  })  : _audioPlayerFactory = audioPlayer ?? getAudioPlayer,
        super(key: key);

  /// The tile to be displayed.
  final Tile tile;

  /// The state of the puzzle.
  final PuzzleState state;

  final AudioPlayerFactory _audioPlayerFactory;

  @override
  State<SlideIslandPuzzleTile> createState() => SlideIslandPuzzleTileState();
}

/// The state of [SlideIslandPuzzleTile].
@visibleForTesting
class SlideIslandPuzzleTileState extends State<SlideIslandPuzzleTile>
    with SingleTickerProviderStateMixin {
  AudioPlayer? _audioPlayer;
  late final Timer _timer;

  /// The controller that drives [_scale] animation.
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: PuzzleThemeAnimationDuration.puzzleTileScale,
    );

    _scale = Tween<double>(begin: 1, end: 0.94).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 1, curve: Curves.easeInOut),
      ),
    );

    // Delay the initialization of the audio player for performance reasons,
    // to avoid dropping frames when the theme is changed.
    _timer = Timer(const Duration(seconds: 1), () {
      _audioPlayer = widget._audioPlayerFactory()
        ..setAsset('assets/audio/tile_move.mp3');
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _audioPlayer?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.state.puzzle.getDimension();
    final theme =
        context.select((SlideIslandThemeBloc bloc) => bloc.state.theme);
    final status =
        context.select((SlideIslandPuzzleBloc bloc) => bloc.state.status);
    final hasStarted = status == SlideIslandPuzzleStatus.started;
    final puzzleIncomplete =
        context.select((PuzzleBloc bloc) => bloc.state.puzzleStatus) ==
            PuzzleStatus.incomplete;
    final currentRound =
        context.select((ServerSyncBloc bloc) => bloc.state.currentRound);

    final movementDuration = status == SlideIslandPuzzleStatus.loading
        ? const Duration(milliseconds: 1)
        : const Duration(milliseconds: 10);

    final canPress = hasStarted && puzzleIncomplete;

    return AudioControlListener(
      audioPlayer: _audioPlayer,
      child: AnimatedAlign(
        alignment: FractionalOffset(
          (widget.tile.currentPosition.x - 1) / (size - 1),
          (widget.tile.currentPosition.y - 1) / (size - 1),
        ),
        duration: movementDuration,
        curve: Curves.easeInOut,
        child: FractionallySizedBox(
          widthFactor: 1 / size,
          heightFactor: 1 / size,
          key: Key('slideisland_puzzle_tile_medium_${widget.tile.value}'),
          child: MouseRegion(
            onEnter: (_) {
              if (canPress) {
                _controller.forward();
              }
            },
            onExit: (_) {
              if (canPress) {
                _controller.reverse();
              }
            },
            child: ScaleTransition(
              key: Key('slideisland_puzzle_tile_scale_${widget.tile.value}'),
              scale: _scale,
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: canPress
                    ? () {
                        context.read<PuzzleBloc>().add(TileTapped(widget.tile));
                        context
                            .read<ServerSyncBloc>()
                            .add(TileTapped(widget.tile));
                        unawaited(_audioPlayer?.replay());
                      }
                    : null,
                icon: ClipRRect(
                  borderRadius: BorderRadius.circular(17),
                  child: Container(
                    color: const Color(0xFFFFFFFF),
                    child: Image.asset(
                      theme.dashAssetForTile(currentRound, widget.tile),
                      semanticLabel: context.l10n.puzzleTileLabelText(
                        widget.tile.value.toString(),
                        widget.tile.currentPosition.x.toString(),
                        widget.tile.currentPosition.y.toString(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
