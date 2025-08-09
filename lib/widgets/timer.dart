import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

class Timer extends StatelessWidget {
  final CountDownController controller;
  final VoidCallback? onComplete;

  const Timer({
    super.key,
    required this.controller,
    this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    // This is a plausible implementation for your Timer widget.
    // It wraps CircularCountDownTimer and forwards the onComplete callback.
    return CircularCountDownTimer(
      // A default duration, which can be changed by the number picker.
      duration: 25 * 60,
      controller: controller,
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 2,
      ringColor: Colors.grey[300]!,
      ringGradient: null,
      fillColor: Theme.of(context).primaryColor,
      fillGradient: null,
      backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.2),
      backgroundGradient: null,
      strokeWidth: 20.0,
      strokeCap: StrokeCap.round,
      textStyle: const TextStyle(
          fontSize: 33.0, color: Colors.white, fontWeight: FontWeight.bold),
      textFormat: CountdownTextFormat.MM_SS,
      isReverse: true,
      isReverseAnimation: false,
      isTimerTextShown: true,
      autoStart: false,
      onComplete: onComplete,
    );
  }
}