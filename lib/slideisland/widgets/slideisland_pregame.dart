// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/serversync/bloc/serversync_bloc.dart';
import 'package:very_good_slide_puzzle/slideisland/themes/slideisland_theme.dart';
import 'package:very_good_slide_puzzle/theme/bloc/theme_bloc.dart';

/// View for when we're doing server connections
class SlideIslandPreGame extends StatelessWidget {
  const SlideIslandPreGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: const [
            Text(
              'Preparing game',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            NextPuzzleDisplaySlideWidget(),
          ],
        );
      },
    );
  }
}

class NextPuzzleDisplaySlideWidget extends StatefulWidget {
  const NextPuzzleDisplaySlideWidget({Key? key}) : super(key: key);

  @override
  State<NextPuzzleDisplaySlideWidget> createState() =>
      _NextPuzzleDisplaySlideWidgetState();
}

class _NextPuzzleDisplaySlideWidgetState
    extends State<NextPuzzleDisplaySlideWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(1, 0),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOut,
  ));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme)
        as SlideIslandTheme;
    final currentRound =
        context.select((ServerSyncBloc bloc) => bloc.state.currentRound);

    return SlideTransition(
      position: _offsetAnimation,
      child: Image.asset(
        theme.assetForRoundComplete(currentRound),
        semanticLabel: 'Round Complete Test',
        fit: BoxFit.fill,
        width: 1080,
      ),
    );
  }
}
