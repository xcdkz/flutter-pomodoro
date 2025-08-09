import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:pomodoro/widgets/custom_number_picker.dart';
import 'package:pomodoro/widgets/timer.dart';
import 'package:sound_mode/sound_mode.dart';
import 'package:sound_mode/utils/ringer_mode_statuses.dart';
import 'package:vibration/vibration.dart';

class Pomodoro extends StatefulWidget {
  const Pomodoro({super.key});

  @override
  State<Pomodoro> createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  final CountDownController _controller = CountDownController();

  void _startTimer() {
    setState(() {
      if (_controller.isPaused.value) {
        _controller.resume();
      } else if (!_controller.isStarted.value) {
        _controller.start();
      }
    });
  }

  void _pauseTimer() async {
    setState(() {
      _controller.pause();
    });
  }

  void _resetTimer() {
    setState(() {
      _controller.reset();
    });
  }

  void _onTimePickerChanged(int value) {
    setState(() {
      _controller.restart(duration: value * 60);
      _controller.pause();
    });
  }

  void _onTimerComplete() async {
    debugPrint("The countdown is complete!");
    RingerModeStatus ringerStatus = RingerModeStatus.unknown;
    Future.delayed(const Duration(milliseconds: 500), () async {
      try {
        ringerStatus = await SoundMode.ringerModeStatus;
      } catch (err) {
        ringerStatus = RingerModeStatus.unknown;
      }
      debugPrint(ringerStatus.toString());
      if (ringerStatus == RingerModeStatus.vibrate) {
        if (await Vibration.hasVibrator()) {
          Vibration.vibrate(duration: 500);
        }
      } else if (ringerStatus == RingerModeStatus.normal) {
        if (await Vibration.hasVibrator()) {
          Vibration.vibrate(duration: 500);
        }
        FlutterRingtonePlayer().playNotification();
      }
    });
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Pomodoro Complete!"),
        content: const Text("Time for a break!"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Pomodoro'))),
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Timer(controller: _controller, onComplete: _onTimerComplete),
            SizedBox(height: 100),
            CustomNumberPicker(onValueChanged: _onTimePickerChanged),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(40, 0, 40, 0),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: _startTimer,
                    child: Icon(Icons.play_arrow),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: _pauseTimer,
                    child: Icon(Icons.pause),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: _resetTimer,
                    child: Icon(Icons.stop),
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
