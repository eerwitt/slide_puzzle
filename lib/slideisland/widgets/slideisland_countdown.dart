import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:very_good_slide_puzzle/audio_control/audio_control.dart';
import 'package:very_good_slide_puzzle/helpers/helpers.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/slideisland/slideisland.dart';
import 'package:very_good_slide_puzzle/timer/timer.dart';
import 'package:very_good_slide_puzzle/typography/typography.dart';

/// {@template slideisland_countdown}
/// Displays the countdown before the puzzle is started.
/// {@endtemplate}
class SlideIslandCountdown extends StatefulWidget {
  /// {@macro slideisland_countdown}
  const SlideIslandCountdown({
    Key? key,
    AudioPlayerFactory? audioPlayer,
  })  : _audioPlayerFactory = audioPlayer ?? getAudioPlayer,
        super(key: key);

  final AudioPlayerFactory _audioPlayerFactory;

  @override
  State<SlideIslandCountdown> createState() => _SlideIslandCountdownState();
}

class _SlideIslandCountdownState extends State<SlideIslandCountdown> {
  late final AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = widget._audioPlayerFactory()
      ..setAsset('assets/audio/shuffle.mp3');
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AudioControlListener(
      audioPlayer: _audioPlayer,
      child: BlocListener<SlideIslandPuzzleBloc, SlideIslandPuzzleState>(
        listener: (context, state) {
          if (!state.isCountdownRunning) {
            return;
          }

          // Play the shuffle sound when the countdown from 3 to 1 begins.
          if (state.secondsToBegin == 3) {
            unawaited(_audioPlayer.replay());
          }

          // Start the puzzle timer when the countdown finishes.
          if (state.status == SlideIslandPuzzleStatus.started) {
            context.read<TimerBloc>().add(const TimerStarted());
          }
        },
        child: ResponsiveLayoutBuilder(
          small: (_, __) => const SizedBox(),
          medium: (_, __) => const SizedBox(),
          large: (_, __) =>
              BlocBuilder<SlideIslandPuzzleBloc, SlideIslandPuzzleState>(
            builder: (context, state) {
              if (!state.isCountdownRunning || state.secondsToBegin > 3) {
                return const SizedBox();
              }

              if (state.secondsToBegin > 0) {
                return SlideIslandCountdownSecondsToBegin(
                  key: ValueKey(state.secondsToBegin),
                  secondsToBegin: state.secondsToBegin,
                );
              } else {
                return const SlideIslandCountdownGo();
              }
            },
          ),
        ),
      ),
    );
  }
}

/// {@template slideisland_countdown_seconds_to_begin}
/// Display how many seconds are left to begin the puzzle.
/// {@endtemplate}
@visibleForTesting
class SlideIslandCountdownSecondsToBegin extends StatefulWidget {
  /// {@macro slideisland_countdown_seconds_to_begin}
  const SlideIslandCountdownSecondsToBegin({
    Key? key,
    required this.secondsToBegin,
  }) : super(key: key);

  /// The number of seconds before the puzzle is started.
  final int secondsToBegin;

  @override
  State<SlideIslandCountdownSecondsToBegin> createState() =>
      _SlideIslandCountdownSecondsToBeginState();
}

class _SlideIslandCountdownSecondsToBeginState
    extends State<SlideIslandCountdownSecondsToBegin>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> inOpacity;
  late Animation<double> inScale;
  late Animation<double> outOpacity;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    inOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.58, curve: Curves.decelerate),
      ),
    );

    inScale = Tween<double>(begin: 0.5, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.58, curve: Curves.decelerate),
      ),
    );

    outOpacity = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.81, 1, curve: Curves.easeIn),
      ),
    );

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme =
        context.select((SlideIslandThemeBloc bloc) => bloc.state.theme);

    return FadeTransition(
      opacity: outOpacity,
      child: FadeTransition(
        opacity: inOpacity,
        child: ScaleTransition(
          scale: inScale,
          child: Text(
            widget.secondsToBegin.toString(),
            style: PuzzleTextStyle.countdownTime.copyWith(
              color: theme.countdownColor,
            ),
          ),
        ),
      ),
    );
  }
}

/// {@template slideisland_countdown_go}
/// Displays a "Go!" text when the countdown reaches 0 seconds.
/// {@endtemplate}
@visibleForTesting
class SlideIslandCountdownGo extends StatefulWidget {
  /// {@macro slideisland_countdown_go}
  const SlideIslandCountdownGo({Key? key}) : super(key: key);

  @override
  State<SlideIslandCountdownGo> createState() => _SlideIslandCountdownGoState();
}

class _SlideIslandCountdownGoState extends State<SlideIslandCountdownGo>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> inOpacity;
  late Animation<double> inScale;
  late Animation<double> outScale;
  late Animation<double> outOpacity;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    inOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.37, curve: Curves.decelerate),
      ),
    );

    inScale = Tween<double>(begin: 0.5, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.37, curve: Curves.decelerate),
      ),
    );

    outOpacity = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.63, 1, curve: Curves.easeIn),
      ),
    );

    outScale = Tween<double>(begin: 1, end: 1.5).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.63, 1, curve: Curves.easeIn),
      ),
    );

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme =
        context.select((SlideIslandThemeBloc bloc) => bloc.state.theme);

    return Padding(
      padding: const EdgeInsets.only(top: 101),
      child: FadeTransition(
        opacity: outOpacity,
        child: FadeTransition(
          opacity: inOpacity,
          child: ScaleTransition(
            scale: outScale,
            child: ScaleTransition(
              scale: inScale,
              child: Text(
                context.l10n.slideislandCountdownGo,
                style: PuzzleTextStyle.countdownTime.copyWith(
                  fontSize: 100,
                  color: theme.defaultColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
