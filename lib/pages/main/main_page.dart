import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:vibration/vibration.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final Duration _initialDuration = const Duration(minutes: 1);
  late Duration _duration;
  late Timer _timer;
  bool _isRunning = true;
  late DateTime _alarmTime;

  @override
  void initState() {
    super.initState();
    _duration = _initialDuration;
    _startTimer();
    _alarmTime = DateTime.now().add(_initialDuration);
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_duration.inSeconds > 0) {
          _duration -= const Duration(seconds: 1);
        } else {
          _timer.cancel();
          _onTimerComplete();
        }
      });
    });
  }

  Future<void> _onTimerComplete() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(pattern: [0, 500, 1000, 500, 1000], repeat: 0);
    }

    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('알림'),
        content: const Text('일어날 시간이에요!'),
        actions: [
          TextButton(
            onPressed: () {
              Vibration.cancel();
              Navigator.of(context).pop();
            },
            child: const Text('확인'),
          )
        ],
      ),
    );
  }

  void _pauseOrResume() {
    setState(() {
      if (_isRunning) {
        _timer.cancel();
        _isRunning = false;
      } else {
        _startTimer();
        _isRunning = true;
      }
    });
  }

  void _cancel() {
    setState(() {
      _timer.cancel();
      _duration = _initialDuration;
      _isRunning = false;
      Vibration.cancel();
    });
  }

  String _formatDuration(Duration duration) {
    return duration.toString().substring(2, 7);
  }

  double _progress() {
    return (_initialDuration.inSeconds - _duration.inSeconds) /
        _initialDuration.inSeconds;
  }

  @override
  void dispose() {
    _timer.cancel();
    Vibration.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${_initialDuration.inMinutes}분',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            CustomPaint(
              painter: TimerPainter(
                backgroundColor: Colors.grey.shade800,
                progressColor: Colors.orange,
                progress: _progress(),
              ),
              child: SizedBox(
                width: 280,
                height: 280,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.notifications_none, color: Colors.white70),
                          const SizedBox(width: 6),
                          Text(
                            '${_alarmTime.hour.toString().padLeft(2, '0')}:${_alarmTime.minute.toString().padLeft(2, '0')}',
                            style: const TextStyle(fontSize: 16, color: Colors.white70),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _formatDuration(_duration),
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _cancel,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(24),
                    ),
                    child: const Text('취소', style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    onPressed: _pauseOrResume,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[700],
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(24),
                    ),
                    child: Text(
                      _isRunning ? '일시 정지' : '재개',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimerPainter extends CustomPainter {
  final Color backgroundColor;
  final Color progressColor;
  final double progress;

  TimerPainter({
    required this.backgroundColor,
    required this.progressColor,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 8.0;
    final radius = (min(size.width, size.height) / 2) - strokeWidth;
    final center = Offset(size.width / 2, size.height / 2);
    final rect = Rect.fromCircle(center: center, radius: radius);

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final progressPaint = Paint()
      ..color = progressColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);
    double sweepAngle = 2 * pi * progress;
    canvas.drawArc(rect, -pi / 2, sweepAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
