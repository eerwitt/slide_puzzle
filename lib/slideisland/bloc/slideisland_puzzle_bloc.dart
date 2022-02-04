import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:very_good_slide_puzzle/models/models.dart';

part 'slideisland_puzzle_event.dart';
part 'slideisland_puzzle_state.dart';

/// {@template slideisland_puzzle_bloc}
/// A bloc responsible for starting the SlideIsland puzzle.
/// {@endtemplate}
class SlideIslandPuzzleBloc
    extends Bloc<SlideIslandPuzzleEvent, SlideIslandPuzzleState> {
  /// {@macro slideisland_puzzle_bloc}
  SlideIslandPuzzleBloc({
    required this.secondsToBegin,
    required Ticker ticker,
  })  : _ticker = ticker,
        super(SlideIslandPuzzleState(secondsToBegin: secondsToBegin)) {
    on<SlideIslandCountdownStarted>(_onCountdownStarted);
    on<SlideIslandCountdownTicked>(_onCountdownTicked);
    on<SlideIslandCountdownStopped>(_onCountdownStopped);
    on<SlideIslandCountdownReset>(_onCountdownReset);
  }

  /// The number of seconds before the puzzle is started.
  final int secondsToBegin;

  final Ticker _ticker;

  StreamSubscription<int>? _tickerSubscription;

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _startTicker() {
    _tickerSubscription?.cancel();
    _tickerSubscription =
        _ticker.tick().listen((_) => add(const SlideIslandCountdownTicked()));
  }

  void _onCountdownStarted(
    SlideIslandCountdownStarted event,
    Emitter<SlideIslandPuzzleState> emit,
  ) {
    _startTicker();
    emit(
      state.copyWith(
        isCountdownRunning: true,
        secondsToBegin: secondsToBegin,
      ),
    );
  }

  void _onCountdownTicked(
    SlideIslandCountdownTicked event,
    Emitter<SlideIslandPuzzleState> emit,
  ) {
    if (state.secondsToBegin == 0) {
      _tickerSubscription?.pause();
      emit(state.copyWith(isCountdownRunning: false));
    } else {
      emit(state.copyWith(secondsToBegin: state.secondsToBegin - 1));
    }
  }

  void _onCountdownStopped(
    SlideIslandCountdownStopped event,
    Emitter<SlideIslandPuzzleState> emit,
  ) {
    _tickerSubscription?.pause();
    emit(
      state.copyWith(
        isCountdownRunning: false,
        secondsToBegin: secondsToBegin,
      ),
    );
  }

  void _onCountdownReset(
    SlideIslandCountdownReset event,
    Emitter<SlideIslandPuzzleState> emit,
  ) {
    _startTicker();
    emit(
      state.copyWith(
        isCountdownRunning: true,
        secondsToBegin: event.secondsToBegin ?? secondsToBegin,
      ),
    );
  }
}
