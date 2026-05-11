part of 'timer_bloc.dart';

sealed class TimerState extends Equatable {
  const TimerState(this.duration);

  final int duration;

  @override
  List<Object> get props => [duration];

  /// Format waktu modern -> 01:30
  String get formattedTime {
    final minutes = duration ~/ 60;
    final seconds = duration % 60;

    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  /// Tampilan debug modern
  @override
  String toString() {
    return '''
╔══════════════════════╗
║      TIMER STATE     ║
╠══════════════════════╣
║ Status   : ${runtimeType.toString()}
║ Duration : $duration s
║ Time     : $formattedTime
╚══════════════════════╝
''';
  }
}

final class TimerInitial extends TimerState {
  const TimerInitial(super.duration);
}

final class TimerRunPause extends TimerState {
  const TimerRunPause(super.duration);
}

final class TimerRunInProgress extends TimerState {
  const TimerRunInProgress(super.duration);
}

final class TimerRunComplete extends TimerState {
  const TimerRunComplete() : super(0);
}