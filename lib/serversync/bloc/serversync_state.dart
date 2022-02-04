import 'package:equatable/equatable.dart';

class ServerSyncState extends Equatable {
  const ServerSyncState(this.messageId);

  final int messageId;

  @override
  List<Object> get props => [messageId];
}
