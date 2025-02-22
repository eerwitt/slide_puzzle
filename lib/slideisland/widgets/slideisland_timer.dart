import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/serversync/bloc/serversync_bloc.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';
import 'package:very_good_slide_puzzle/typography/typography.dart';

/// {@template slideisland_timer}
/// Displays how many seconds elapsed since starting the puzzle.
/// {@endtemplate}
class SlideIslandTimer extends StatelessWidget {
  /// {@macro slideisland_timer}
  const SlideIslandTimer({
    Key? key,
    this.textStyle,
    this.iconSize,
    this.iconPadding,
    this.mainAxisAlignment,
  }) : super(key: key);

  /// The optional [TextStyle] of this timer.
  final TextStyle? textStyle;

  /// The optional icon [Size] of this timer.
  final Size? iconSize;

  /// The optional icon padding of this timer.
  final double? iconPadding;

  /// The optional [MainAxisAlignment] of this timer.
  /// Defaults to [MainAxisAlignment.center] if not provided.
  final MainAxisAlignment? mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final secondsRemaining =
        context.select((ServerSyncBloc bloc) => bloc.state.secondsRemaining);

    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, child) => child!,
      large: (_, child) => child!,
      child: (currentSize) {
        final currentTextStyle = textStyle ??
            (currentSize == ResponsiveLayoutSize.small
                ? PuzzleTextStyle.headline4
                : PuzzleTextStyle.headline3);

        final currentIconSize = iconSize ??
            (currentSize == ResponsiveLayoutSize.small
                ? const Size(28, 28)
                : const Size(32, 32));

        final timeRemaining = Duration(seconds: secondsRemaining);

        return Row(
          key: const Key('slideisland_timer'),
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/timer_icon.png',
              key: const Key('slideisland_timer_icon'),
              width: currentIconSize.width,
              height: currentIconSize.height,
            ),
            Gap(iconPadding ?? 8),
            AnimatedDefaultTextStyle(
              style: currentTextStyle.copyWith(
                color: PuzzleColors.black,
              ),
              duration: PuzzleThemeAnimationDuration.textStyle,
              child: Text(
                _formatDuration(timeRemaining),
                key: ValueKey(secondsRemaining),
                semanticsLabel: _getDurationLabel(timeRemaining, context),
              ),
            ),
            // const SizedBox(
            //   width: 100,
            //   height: 100,
            //   child: RiveAnimation.asset(
            //     'animations/timer_icon.riv',
            //     fit: BoxFit.cover,
            //   ),
            // ),
          ],
        );
      },
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  }

  String _getDurationLabel(Duration duration, BuildContext context) {
    return context.l10n.slideislandPuzzleDurationLabelText(
      duration.inHours.toString(),
      duration.inMinutes.remainder(60).toString(),
      duration.inSeconds.remainder(60).toString(),
    );
  }
}
