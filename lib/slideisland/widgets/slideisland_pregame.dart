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
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme)
        as SlideIslandTheme;
    final currentRound =
        context.select((ServerSyncBloc bloc) => bloc.state.currentRound);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            const Text(
              'Preparing game',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Image.asset(
              theme.assetForRoundComplete(currentRound),
              semanticLabel: 'Round Complete Test',
            ),
          ],
        );
      },
    );
  }
}
