import 'package:equatable/equatable.dart';

import 'package:slide_puzzle_shared/bloc/puzzle_bloc.dart';

class ServerSyncEvent extends PuzzleEvent {
  const ServerSyncEvent();

  @override
  List<Object> get props => [];
}

class ConnectToServerEvent extends ServerSyncEvent {
  const ConnectToServerEvent(this.connecturi);

  final String connecturi;

  @override
  List<Object> get props => [connecturi];
}

class DisconnectFromServerEvent extends ServerSyncEvent {
  const DisconnectFromServerEvent();

  @override
  List<Object> get props => [];
}

class FindMatchEvent extends ServerSyncEvent {
  const FindMatchEvent();

  @override
  List<Object> get props => [];
}
