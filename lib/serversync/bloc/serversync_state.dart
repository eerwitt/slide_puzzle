import 'package:equatable/equatable.dart';

class ServerSyncState extends Equatable {
  const ServerSyncState({required this.messageId, required this.playerRank});

  final int messageId;
  final int playerRank;

  @override
  List<Object> get props => [messageId, playerRank];

  ServerSyncState copyWith({
    int? messageId,
    int? playerRank,
  }) {
    return ServerSyncState(
      messageId: messageId ?? this.messageId,
      playerRank: playerRank ?? this.playerRank,
    );
  }
}
