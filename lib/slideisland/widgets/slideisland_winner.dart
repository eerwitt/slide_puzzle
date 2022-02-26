// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/serversync/bloc/serversync_bloc.dart';
import 'package:very_good_slide_puzzle/serversync/bloc/serversync_event.dart';

class SlideIslandWinner extends StatefulWidget {
  const SlideIslandWinner({Key? key}) : super(key: key);

  @override
  _SlideIslandWinnerState createState() => _SlideIslandWinnerState();
}

class _SlideIslandWinnerState extends State<SlideIslandWinner> {
  bool replayPushed = false;

  @override
  void initState() {
    super.initState();
    replayPushed = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Winner winner ice cream dinner! You slide past all the competition and won.',
          textAlign: TextAlign.center,
          overflow: TextOverflow.visible,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Image.asset(
          'assets/images/slideisland/win.png',
          height: 600,
          fit: BoxFit.fitHeight,
        ),
        ElevatedButton(
          onPressed: !replayPushed
              ? () {
                  context.read<ServerSyncBloc>().add(
                        const ConnectToServerEvent(
                          'wss://slide-puzzle-server-zle2slktuq-wl.a.run.app:443/ws',
                        ),
                      );
                  _onReplayPressed();
                }
              : null,
          child: const Text(
            'Play Again',
            textAlign: TextAlign.center,
            overflow: TextOverflow.visible,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  void _onReplayPressed() {
    setState(() {
      replayPushed = true;
    });
  }
}
