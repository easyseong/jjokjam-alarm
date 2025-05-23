import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibration/vibration.dart';

import '../../providers/timer_notifier.dart';
import '../../services/timer_painter.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  void _showCompletionDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder:
          (context) => CupertinoAlertDialog(
            title: const Text('알림'),
            content: const Text('일어날 시간이에요!'),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Vibration.cancel();
                  Navigator.of(context).pop();
                },
                child: const Text('확인'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerState = ref.watch(timerNotifierProvider);
    final notifier = ref.read(timerNotifierProvider.notifier);

    ref.listen(timerNotifierProvider, (prev, next) {
      if (prev?.isRunning == true &&
          next.isRunning == false &&
          next.remaining.inSeconds == 0) {
        _showCompletionDialog(context);
      }
    });

    final formatted = timerState.remaining.toString().substring(2, 7);
    final alarmTime = timerState.alarmTime;

    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.black,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${TimerNotifier.initialDuration.inMinutes}분',
              style: const TextStyle(
                fontSize: 20,
                color: CupertinoColors.white,
              ),
            ),
            const SizedBox(height: 20),
            CustomPaint(
              painter: TimerPainter(
                backgroundColor: CupertinoColors.systemGrey,
                progressColor: CupertinoColors.activeOrange,
                progress: timerState.progress,
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
                          const Icon(
                            CupertinoIcons.bell_fill,
                            color: CupertinoColors.systemGrey,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${alarmTime.hour.toString().padLeft(2, '0')}:${alarmTime.minute.toString().padLeft(2, '0')}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: CupertinoColors.systemGrey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        formatted,
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: CupertinoColors.white,
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
                  CupertinoButton(
                    padding: const EdgeInsets.all(24),
                    color: CupertinoColors.systemGrey,
                    borderRadius: BorderRadius.circular(100),
                    onPressed: () => notifier.cancel(),
                    child: const Text(
                      '취소',
                      style: TextStyle(color: CupertinoColors.white),
                    ),
                  ),
                  CupertinoButton(
                    padding: const EdgeInsets.all(24),
                    color: CupertinoColors.activeOrange,
                    borderRadius: BorderRadius.circular(100),
                    onPressed: () => notifier.toggle(),
                    child: Text(
                      timerState.isRunning ? '일시 정지' : '재개',
                      style: const TextStyle(color: CupertinoColors.white),
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
