import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const TimerPage(),
    );
  }
}

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  final int totalDuration = 60;

  int duration = 60;

  Timer? timer;

  bool isRunning = false;

  void startTimer() {
    if (isRunning) return;

    isRunning = true;

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (duration > 0) {
          setState(() {
            duration--;
          });
        } else {
          timer.cancel();

          setState(() {
            isRunning = false;
          });
        }
      },
    );

    setState(() {});
  }

  void pauseTimer() {
    timer?.cancel();

    setState(() {
      isRunning = false;
    });
  }

  void resetTimer() {
    timer?.cancel();

    setState(() {
      duration = totalDuration;
      isRunning = false;
    });
  }

  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:'
        '${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = duration / totalDuration;

    return Scaffold(
      body: Container(
        width: double.infinity,

        /// SOFT PINK BACKGROUND
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xfffff1f5),
              Color(0xffffd6e7),
              Color(0xffffb7d5),
            ],
          ),
        ),

        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),

              /// TITLE
              const Text(
                'Focus Timer',
                style: TextStyle(
                  color: Color(0xff9d174d),
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                isRunning
                    ? 'Stay focused'
                    : duration == 0
                        ? 'Completed'
                        : 'Ready to Focus',
                style: const TextStyle(
                  color: Color(0xffbe185d),
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const Spacer(),

              /// TIMER
              SizedBox(
                width: 320,
                height: 320,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    /// SHADOW
                    Container(
                      width: 320,
                      height: 320,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.pink.withOpacity(0.25),
                            blurRadius: 40,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                    ),

                    /// PROGRESS
                    SizedBox(
                      width: 300,
                      height: 300,
                      child: CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 13,
                        backgroundColor: Colors.white70,
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(
                          Color(0xffec4899),
                        ),
                      ),
                    ),

                    /// INNER CIRCLE
                    Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xfffff1f2),
                            Color(0xffffdce8),
                          ],
                        ),
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                    ),

                    /// TIMER TEXT
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          formatTime(duration),
                          style: const TextStyle(
                            color: Color(0xff9d174d),
                            fontSize: 72,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Text(
                          isRunning
                              ? 'Running'
                              : duration == 0
                                  ? 'Done'
                                  : 'Ready',
                          style: const TextStyle(
                            color: Color(0xffbe185d),
                            fontSize: 22,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Spacer(),

              /// BUTTONS
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildSmallButton(
                    icon: Icons.replay,
                    color: const Color(0xffec4899),
                    onTap: resetTimer,
                  ),

                  const SizedBox(width: 25),

                  /// PLAY / PAUSE
                  GestureDetector(
                    onTap: () {
                      if (isRunning) {
                        pauseTimer();
                      } else {
                        startTimer();
                      }
                    },
                    child: Container(
                      width: 95,
                      height: 95,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: isRunning
                              ? [
                                  const Color(0xfffb7185),
                                  const Color(0xfff43f5e),
                                ]
                              : [
                                  const Color(0xfff9a8d4),
                                  const Color(0xffec4899),
                                ],
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.pink.withOpacity(0.35),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Icon(
                        isRunning
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 55,
                      ),
                    ),
                  ),

                  const SizedBox(width: 25),

                  buildSmallButton(
                    icon: Icons.stop,
                    color: const Color(0xffec4899),
                    onTap: pauseTimer,
                  ),
                ],
              ),

              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  static Widget buildSmallButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.35),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: Colors.white,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.pink.withOpacity(0.12),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: color,
          size: 34,
        ),
      ),
    );
  }
}