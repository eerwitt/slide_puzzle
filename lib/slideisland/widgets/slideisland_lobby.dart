// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/serversync/bloc/serversync_bloc.dart';
import 'package:very_good_slide_puzzle/serversync/bloc/serversync_event.dart';

class SlideIslandLobby extends StatefulWidget {
  const SlideIslandLobby({Key? key}) : super(key: key);

  @override
  _SlideIslandLobbyState createState() => _SlideIslandLobbyState();
}

/// View for when we're doing server connections
class _SlideIslandLobbyState extends State<SlideIslandLobby> {
  bool forceReadyPushed = false;

  @override
  void initState() {
    super.initState();
    forceReadyPushed = false;
  }

  @override
  Widget build(BuildContext context) {
    final playerState = context.select((ServerSyncBloc bloc) => bloc.state);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Text(
              'In Lobby, Waiting for players ${playerState.playersConnected} / 100',
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Image.asset(
              'assets/images/slideisland/main-screen.png',
              height: 600,
              fit: BoxFit.fitHeight,
            ),
            ElevatedButton(
              onPressed: !forceReadyPushed
                  ? () {
                      context
                          .read<ServerSyncBloc>()
                          .add(const ForceMatchReadyEvent());
                      _onReplayPressed();
                    }
                  : null,
              child: const Text(
                'Start Match',
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  void _onReplayPressed() {
    setState(() {
      forceReadyPushed = true;
    });
  }
}
