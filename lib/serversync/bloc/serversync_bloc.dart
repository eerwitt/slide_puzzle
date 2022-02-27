// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:slide_puzzle_shared/bloc/puzzle_bloc.dart';
import 'package:slide_puzzle_shared/messages/general.dart';
import 'package:very_good_slide_puzzle/serversync/bloc/serversync_event.dart';
import 'package:very_good_slide_puzzle/serversync/bloc/serversync_state.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ServerMessageEvent extends PuzzleEvent {}

class ServerSyncBloc extends Bloc<PuzzleEvent, ServerSyncState> {
  ServerSyncBloc(this.puzzleBloc)
      : super(
          const ServerSyncState(
            messageId: 1,
            playerRank: 1,
            playersToMoveOn: 1,
            playerScore: 0,
            currentRound: 1,
            gameState: GameState.GameOver,
            playerState: PlayerState.Connecting,
            numberOfRounds: 1,
            secondsRemaining: 0,
            playersConnected: 1,
          ),
        ) {
    on<ConnectToServerEvent>(_onConnectToServer);
    on<DisconnectFromServerEvent>(_onDisconnectFromServer);
    on<TileTapped>(_onPuzzleTileTapped);
    on<MessageReceivedEvent>(_onMessageReceived);
    on<ForceMatchReadyEvent>(_onForceMatchReady);
  }

  WebSocketChannel? channel;
  final PuzzleBloc puzzleBloc;

  void _onConnectToServer(
      ConnectToServerEvent event, Emitter<ServerSyncState> emit) {
    emit(state.copyWith(playerState: PlayerState.Connecting));
    channel = WebSocketChannel.connect(
      Uri.parse(event.connecturi /* 'ws://127.0.0.1:4040/ws' */),
    );

    channel?.stream.listen(
      (dynamic message) =>
          add(MessageReceivedEvent(message as String, channel!.sink)),
      onError: (Object error, StackTrace stacktrace) =>
          add(const DisconnectFromServerEvent()),
      onDone: () {},
    );

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
    emit(state.copyWith(
      playerState: PlayerState.Disconnecting,
      gameState: GameState.GameOver,
    ));
  }

  void _onPuzzleTileTapped(TileTapped event, Emitter<ServerSyncState> emit) {
    final message = BaseMessage(
      id: state.messageId,
      messageType: MessageType.TileTapped,
      payload: event.toJson(),
      valid: true,
    );

    channel?.sink.add(message.toRawJson());
  }

  void _onMessageReceived(
      MessageReceivedEvent event, Emitter<ServerSyncState> emit) {
    final message = BaseMessage.fromRawJson(event.rawMessage);

    switch (message.messageType) {
      case MessageType.CreatePlayer:
        final response = BaseMessage(
            id: state.messageId,
            messageType: MessageType.FindMatch,
            payload: <String, dynamic>{},
            valid: true);

        event.websocketSink.add(response.toRawJson());
        break;
      case MessageType.FindMatch:
        break;
      case MessageType.TileTapped:
        break;
      case MessageType.PuzzleSetup:
        final puzzleSetup = PuzzleSetup.fromJson(message.payload);
        puzzleBloc.add(puzzleSetup);

        break;
      case MessageType.MatchUpdate:
        final matchUpdate = MatchUpdateEvent.fromJson(message.payload);
        emit(state.copyWith(
          currentRound: matchUpdate.currentRound,
          numberOfRounds: matchUpdate.numberOfRounds,
          gameState: matchUpdate.gameState,
          playerState: matchUpdate.playerState,
          secondsRemaining: matchUpdate.secondsRemainingInCurrentState,
          playersConnected: matchUpdate.playersConnected,
        ));

        break;
      case MessageType.RoundUpdate:
        final roundUpdate = RoundUpdateEvent.fromJson(message.payload);
        emit(state.copyWith(
          playerRank: roundUpdate.playerRank,
          playerScore: roundUpdate.currentScore,
          playersToMoveOn: roundUpdate.playersToMoveOn,
        ));

        break;
      case MessageType.HealthCheck:
        break;
      case MessageType.StartMatch:
        break;
    }
  }

  void _onForceMatchReady(
      ForceMatchReadyEvent event, Emitter<ServerSyncState> emit) {
    final message = BaseMessage(
      id: state.messageId,
      messageType: MessageType.StartMatch,
      payload: <String, dynamic>{},
      valid: true,
    );

    channel?.sink.add(message.toRawJson());
  }
}
