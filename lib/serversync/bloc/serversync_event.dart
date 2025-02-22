// ignore_for_file: public_member_api_docs

import 'package:slide_puzzle_shared/bloc/puzzle_bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

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

class ForceMatchReadyEvent extends ServerSyncEvent {
  const ForceMatchReadyEvent();

  @override
  List<Object> get props => [];
}

class MessageReceivedEvent extends ServerSyncEvent {
  const MessageReceivedEvent(this.rawMessage, this.websocketSink);

  final String rawMessage;
  final WebSocketSink websocketSink;

  @override
  List<Object> get props => [rawMessage, websocketSink];
}
