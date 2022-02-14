// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/serversync/bloc/serversync_bloc.dart';

/// View for when we're doing server connections
class SlideIslandLobby extends StatelessWidget {
  const SlideIslandLobby({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final playerState = context.select((ServerSyncBloc bloc) => bloc.state);
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Text(
              'In Lobby, Waiting for players ${playerState.playersConnected} / 100',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        );
      },
    );
  }
}
