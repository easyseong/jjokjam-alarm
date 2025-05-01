import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final timerNotifierProvider = StateNotifierProvider<TimerNotifier, TimerState>((
  ref,
) {
  return TimerNotifier();
});

class TimerState {
  final Duration remaining;
  final bool isRunning;
  final DateTime alarmTime;

  TimerState({
    required this.remaining,
    required this.isRunning,
    required this.alarmTime,
  });

  double get progress =>
      (TimerNotifier.initialDuration.inSeconds - remaining.inSeconds) /
      TimerNotifier.initialDuration.inSeconds;
}

class TimerNotifier extends StateNotifier<TimerState> {
  static const Duration initialDuration = Duration(minutes: 1);
  Timer? _timer;

  TimerNotifier()
    : super(
        TimerState(
          remaining: initialDuration,
          isRunning: false,
          alarmTime: DateTime.now().add(initialDuration),
        ),
      );

  void _tick() {
    final now = DateTime.now();
    final remaining = state.alarmTime.difference(now);
    if (remaining <= Duration.zero) {
      _timer?.cancel();
      state = TimerState(
        remaining: Duration.zero,
        isRunning: false,
        alarmTime: state.alarmTime,
      );
    } else {
      state = TimerState(
        remaining: remaining,
        isRunning: true,
        alarmTime: state.alarmTime,
      );
    }
  }

  void start() {
    if (state.isRunning) return;
    final alarm = DateTime.now().add(state.remaining);
    state = TimerState(
      remaining: state.remaining,
      isRunning: true,
      alarmTime: alarm,
    );
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void stop() {
    _timer?.cancel();
    state = TimerState(
      remaining: state.remaining,
      isRunning: false,
      alarmTime: state.alarmTime,
    );
  }

  void toggle() {
    state.isRunning ? stop() : start();
  }

  void cancel() {
    _timer?.cancel();
    state = TimerState(
      remaining: initialDuration,
      isRunning: false,
      alarmTime: DateTime.now().add(initialDuration),
    );
  }
}
