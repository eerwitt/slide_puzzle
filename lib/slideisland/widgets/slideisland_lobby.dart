// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/serversync/bloc/serversync_bloc.dart';
import 'package:very_good_slide_puzzle/serversync/bloc/serversync_event.dart';
import 'package:very_good_slide_puzzle/slideisland/widgets/display_slide.dart';
import 'package:very_good_slide_puzzle/slideisland/widgets/slideisland_timer.dart';

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
            const Text(
              'Act fast, slide tiles into place faster than anyone else to proceed to the next round!',
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DisplaySlideWidget(
              child: Image.asset(
                'assets/images/slideisland/main-screen.png',
                height: 400,
                fit: BoxFit.fitHeight,
              ),
            ),
            Text(
              'Waiting for more players (${playerState.playersConnected} / 100).',
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text(
              'Automatically starting match in:',
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SlideIslandTimer(),
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
                'Start Match Early',
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
