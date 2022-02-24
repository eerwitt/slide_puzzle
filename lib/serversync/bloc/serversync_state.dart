// ignore_for_file: public_member_api_docs

import 'package:equatable/equatable.dart';
import 'package:slide_puzzle_shared/messages/general.dart';

class ServerSyncState extends Equatable {
  const ServerSyncState({
    required this.messageId,
    required this.playerRank,
    required this.playersToMoveOn,
    required this.playerScore,
    required this.secondsRemaining,
    required this.playersConnected,
    required this.currentRound,
    required this.numberOfRounds,
    required this.gameState,
    required this.playerState,
  });

  final int messageId;
  final int playerRank;
  final int playersToMoveOn;
  final int playerScore;
  final int secondsRemaining;
  final int playersConnected;
  final int currentRound;
  final int numberOfRounds;
  final GameState gameState;
  final PlayerState playerState;

  @override
  List<Object> get props => [
        messageId,
        playerRank,
        playersToMoveOn,
        playerScore,
        secondsRemaining,
        playersConnected,
        currentRound,
        numberOfRounds,
        gameState,
        playerState
      ];

  ServerSyncState copyWith(
      {int? messageId,
      int? playerRank,
      int? playersToMoveOn,
      int? playerScore,
      int? secondsRemaining,
      int? playersConnected,
      int? currentRound,
      int? numberOfRounds,
      GameState? gameState,
      PlayerState? playerState}) {
    return ServerSyncState(
      messageId: messageId ?? this.messageId,
      playerRank: playerRank ?? this.playerRank,
      playersToMoveOn: playersToMoveOn ?? this.playersToMoveOn,
      playerScore: playerScore ?? this.playerScore,
      secondsRemaining: secondsRemaining ?? this.secondsRemaining,
      playersConnected: playersConnected ?? this.playersConnected,
      currentRound: currentRound ?? this.currentRound,
      numberOfRounds: numberOfRounds ?? this.numberOfRounds,
      gameState: gameState ?? this.gameState,
      playerState: playerState ?? this.playerState,
    );
  }
}
