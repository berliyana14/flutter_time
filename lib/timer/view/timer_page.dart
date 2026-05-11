import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_time/ticker.dart';
import 'package:flutter_time/timer/bloc/timer_bloc.dart';
import 'package:flutter_time/timer/timer.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimerBloc(ticker: Ticker()),
      child: const TimerView(),
    );
  }
}

class TimerView extends StatelessWidget {
  const TimerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff0f172a),
              Color(0xff1e3a8a),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),

              const Text(
                'Flutter Timer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 60),

              const Expanded(
                child: Center(
                  child: TimerCircle(),
                ),
              ),

              const SizedBox(height: 40),

              const Actions(),

              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}

class TimerCircle extends StatelessWidget {
  const TimerCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final duration = context.select(
      (TimerBloc bloc) => bloc.state.duration,
    );

    final minutesStr =
        ((duration / 60) % 60).floor().toString().padLeft(2, '0');

    final secondsStr =
        (duration % 60).floor().toString().padLeft(2, '0');

    final progress = duration / 60;

    return SizedBox(
      width: 260,
      height: 260,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 260,
            height: 260,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 12,
              backgroundColor: Colors.white12,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$minutesStr:$secondsStr',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              BlocBuilder<TimerBloc, TimerState>(
                builder: (context, state) {
                  String text = '';

                  if (state is TimerInitial) {
                    text = 'Ready';
                  } else if (state is TimerRunInProgress) {
                    text = 'Running';
                  } else if (state is TimerRunPause) {
                    text = 'Paused';
                  } else if (state is TimerRunComplete) {
                    text = 'Completed';
                  }

                  return Text(
                    text,
                    style: TextStyle(
                      color: Colors.white.withOpacity(.8),
                      fontSize: 20,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Actions extends StatelessWidget {
  const Actions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      buildWhen: (prev, state) =>
          prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...switch (state) {
              TimerInitial() => [
                  _ActionButton(
                    icon: Icons.play_arrow,
                    color: Colors.green,
                    onPressed: () {
                      context.read<TimerBloc>().add(
                            TimerStarted(
                              duration: state.duration,
                            ),
                          );
                    },
                  ),
                ],

              TimerRunInProgress() => [
                  _ActionButton(
                    icon: Icons.pause,
                    color: Colors.orange,
                    onPressed: () {
                      context
                          .read<TimerBloc>()
                          .add(const TimerPaused());
                    },
                  ),

                  const SizedBox(width: 20),

                  _ActionButton(
                    icon: Icons.replay,
                    color: Colors.red,
                    onPressed: () {
                      context
                          .read<TimerBloc>()
                          .add(const TimerReset());
                    },
                  ),
                ],

              TimerRunPause() => [
                  _ActionButton(
                    icon: Icons.play_arrow,
                    color: Colors.green,
                    onPressed: () {
                      context
                          .read<TimerBloc>()
                          .add(const TimerResumed());
                    },
                  ),

                  const SizedBox(width: 20),

                  _ActionButton(
                    icon: Icons.replay,
                    color: Colors.red,
                    onPressed: () {
                      context
                          .read<TimerBloc>()
                          .add(const TimerReset());
                    },
                  ),
                ],

              TimerRunComplete() => [
                  _ActionButton(
                    icon: Icons.replay,
                    color: Colors.blue,
                    onPressed: () {
                      context
                          .read<TimerBloc>()
                          .add(const TimerReset());
                    },
                  ),
                ],
            }
          ],
        );
      },
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 10,
      backgroundColor: color,
      onPressed: onPressed,
      child: Icon(
        icon,
        size: 32,
      ),
    );
  }
}