import 'package:bloc/bloc.dart';
import 'package:slide_puzzle_shared/bloc/puzzle_bloc.dart';
import 'package:slide_puzzle_shared/messages/general.dart';
import 'package:very_good_slide_puzzle/serversync/bloc/serversync_event.dart';
import 'package:very_good_slide_puzzle/serversync/bloc/serversync_state.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// ignore: public_member_api_docs
class ServerSyncBloc extends Bloc<PuzzleEvent, ServerSyncState> {
  // ignore: public_member_api_docs
  ServerSyncBloc(this.puzzleBloc) : super(const ServerSyncState(1)) {
    on<ConnectToServerEvent>(_onConnectToServer);
    on<DisconnectFromServerEvent>(_onDisconnectFromServer);
    on<TileTapped>(_onPuzzleTileTapped);
  }

  WebSocketChannel? channel;
  final PuzzleBloc puzzleBloc;

  void _onConnectToServer(
      ConnectToServerEvent event, Emitter<ServerSyncState> emit) {
    channel = WebSocketChannel.connect(
      Uri.parse(event.connecturi /* 'ws://127.0.0.1:4040/ws' */),
    );

    channel?.stream.listen((dynamic message) =>
        _onMessageFromServer(message, channel!.sink, emit));

    final message = BaseMessage(
      id: state.messageId,
      messageType: MessageType.CreatePlayer,
      payload: <String, dynamic>{},
      valid: true,
    );
    channel?.sink.add(message.toRawJson());
  }

  void _onDisconnectFromServer(
      DisconnectFromServerEvent event, Emitter<ServerSyncState> emit) {
    channel?.sink.close();
  }

  void _onPuzzleTileTapped(TileTapped event, Emitter<ServerSyncState> emit) {}

  void _onMessageFromServer(
      dynamic rawMessage, WebSocketSink sink, Emitter<ServerSyncState> emit) {
    // TODO: emit the state changes on valid message
    final message = BaseMessage.fromRawJson(rawMessage as String);

    switch (message.messageType) {
      case MessageType.CreatePlayer:
        final response = BaseMessage(
            id: state.messageId,
            messageType: MessageType.FindMatch,
            payload: <String, dynamic>{},
            valid: true);

        sink.add(response.toRawJson());
        break;
      case MessageType.FindMatch:
        // TODO: Handle this case.
        break;
      case MessageType.MoveTile:
        // TODO: Handle this case.
        break;
      case MessageType.PuzzleSetup:
        final puzzleSetup = PuzzleSetup.fromJson(message.payload);
        puzzleBloc.add(puzzleSetup);

        break;
    }
  }
}
