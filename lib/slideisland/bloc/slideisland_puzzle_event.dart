// ignore_for_file: public_member_api_docs

part of 'slideisland_puzzle_bloc.dart';

abstract class SlideIslandPuzzleEvent extends Equatable {
  const SlideIslandPuzzleEvent();

  @override
  List<Object?> get props => [];
}

class SlideIslandCountdownStarted extends SlideIslandPuzzleEvent {
  const SlideIslandCountdownStarted();
}

class SlideIslandCountdownTicked extends SlideIslandPuzzleEvent {
  const SlideIslandCountdownTicked();
}

class SlideIslandCountdownStopped extends SlideIslandPuzzleEvent {
  const SlideIslandCountdownStopped();
}

class SlideIslandCountdownReset extends SlideIslandPuzzleEvent {
  const SlideIslandCountdownReset({this.secondsToBegin});

  /// The number of seconds to countdown from.
  /// Defaults to [SlideIslandPuzzleBloc.secondsToBegin] if null.
  final int? secondsToBegin;

  @override
  List<Object?> get props => [secondsToBegin];
}
