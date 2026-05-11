part of 'timer_bloc.dart';

sealed class TimerEvent {
  const TimerEvent();
}

/// START TIMER
final class TimerStarted extends TimerEvent {
  const TimerStarted({required this.duration});

  final int duration;
}

/// PAUSE TIMER
final class TimerPaused extends TimerEvent {
  const TimerPaused();
}

/// RESUME TIMER
final class TimerResumed extends TimerEvent {
  const TimerResumed();
}

/// RESET TIMER
final class TimerReset extends TimerEvent {
  const TimerReset();
}

/// TICK EVENT
final class _TimerTicked extends TimerEvent {
  const _TimerTicked({required this.duration});

  final int duration;
}

/// ===============================
/// TAMBAHAN PENGEMBANGAN
/// ===============================

/// MENAMBAH WAKTU TIMER
final class TimerAdded extends TimerEvent {
  const TimerAdded({required this.extraTime});

  final int extraTime;
}

/// MENGURANGI WAKTU TIMER
final class TimerSubtracted extends TimerEvent {
  const TimerSubtracted({required this.minusTime});

  final int minusTime;
}

/// GANTI WARNA / THEME TIMER
final class TimerThemeChanged extends TimerEvent {
  const TimerThemeChanged({required this.isDark});

  final bool isDark;
}

/// MODE STOPWATCH
final class StopwatchStarted extends TimerEvent {
  const StopwatchStarted();
}

/// STOP STOPWATCH
final class StopwatchStopped extends TimerEvent {
  const StopwatchStopped();
}

/// RESET STOPWATCH
final class StopwatchReset extends TimerEvent {
  const StopwatchReset();
}

/// TIMER SELESAI
final class TimerCompleted extends TimerEvent {
  const TimerCompleted();
}

/// NOTIFIKASI TIMER
final class TimerNotificationRequested extends TimerEvent {
  const TimerNotificationRequested();
}

/// SOUND ALARM TIMER
final class TimerAlarmPlayed extends TimerEvent {
  const TimerAlarmPlayed();
}

/// MODE POMODORO
final class PomodoroStarted extends TimerEvent {
  const PomodoroStarted({
    required this.workDuration,
    required this.breakDuration,
  });

  final int workDuration;
  final int breakDuration;
}

/// PINDAH SESSION POMODORO
final class PomodoroSwitched extends TimerEvent {
  const PomodoroSwitched();
}

/// SIMPAN HISTORY TIMER
final class TimerHistorySaved extends TimerEvent {
  const TimerHistorySaved({
    required this.finishedTime,
  });

  final DateTime finishedTime;
}

/// LOAD HISTORY TIMER
final class TimerHistoryLoaded extends TimerEvent {
  const TimerHistoryLoaded();
}

/// HAPUS HISTORY TIMER
final class TimerHistoryCleared extends TimerEvent {
  const TimerHistoryCleared();
}