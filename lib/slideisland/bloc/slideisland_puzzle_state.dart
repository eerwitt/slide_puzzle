// ignore_for_file: public_member_api_docs

part of 'slideisland_puzzle_bloc.dart';

/// The status of [SlideIslandPuzzleState].
enum SlideIslandPuzzleStatus {
  /// The puzzle is not started yet.
  notStarted,

  /// The puzzle is loading.
  loading,

  /// The puzzle is started.
  started
}

class SlideIslandPuzzleState extends Equatable {
  const SlideIslandPuzzleState({
    required this.secondsToBegin,
    this.isCountdownRunning = false,
  });

  /// Whether the countdown of this puzzle is currently running.
  final bool isCountdownRunning;

  /// The number of seconds before the puzzle is started.
  final int secondsToBegin;

  /// The status of the current puzzle.
  SlideIslandPuzzleStatus get status => SlideIslandPuzzleStatus
          .started /*isCountdownRunning && secondsToBegin > 0
      ? SlideIslandPuzzleStatus.loading
      : (secondsToBegin == 0
          ? SlideIslandPuzzleStatus.started
          : SlideIslandPuzzleStatus.notStarted)*/
      ;

  @override
  List<Object> get props => [isCountdownRunning, secondsToBegin];

  SlideIslandPuzzleState copyWith({
    bool? isCountdownRunning,
    int? secondsToBegin,
  }) {
    return SlideIslandPuzzleState(
      isCountdownRunning: isCountdownRunning ?? this.isCountdownRunning,
      secondsToBegin: secondsToBegin ?? this.secondsToBegin,
    );
  }
}
