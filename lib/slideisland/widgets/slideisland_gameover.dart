// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/serversync/bloc/serversync_bloc.dart';
import 'package:very_good_slide_puzzle/serversync/bloc/serversync_event.dart';

/// View for when we're doing server connections
class SlideIslandGameOver extends StatelessWidget {
  const SlideIslandGameOver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ).copyWith(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
      onPressed: () {
        context.read<ServerSyncBloc>().add(const ConnectToServerEvent(
              'wss://slide-puzzle-server-zle2slktuq-wl.a.run.app:443/ws',
            ));
      },
      child: const Text(
        'Game over',
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
