// ignore_for_file: public_member_api_docs

import 'package:equatable/equatable.dart';
import 'package:slide_puzzle_shared/messages/general.dart';

class ServerSyncState extends Equatable {
  const ServerSyncState(
      {required this.messageId,
      required this.playerRank,
      required this.secondsRemaining,
      required this.currentRound,
      required this.numberOfRounds,
      required this.gameState,
      required this.playerState});

  final int messageId;
  final int playerRank;
  final int secondsRemaining;
  final int currentRound;
  final int numberOfRounds;
  final GameState gameState;
  final PlayerState playerState;

  @override
  List<Object> get props => [
        messageId,
        playerRank,
        secondsRemaining,
        currentRound,
        numberOfRounds,
        gameState,
        playerState
      ];

  ServerSyncState copyWith(
      {int? messageId,
      int? playerRank,
      int? secondsRemaining,
      int? currentRound,
      int? numberOfRounds,
      GameState? gameState,
      PlayerState? playerState}) {
    return ServerSyncState(
      messageId: messageId ?? this.messageId,
      playerRank: playerRank ?? this.playerRank,
      secondsRemaining: secondsRemaining ?? this.secondsRemaining,
      currentRound: currentRound ?? this.currentRound,
      numberOfRounds: numberOfRounds ?? this.numberOfRounds,
      gameState: gameState ?? this.gameState,
      playerState: playerState ?? this.playerState,
    );
  }
}
