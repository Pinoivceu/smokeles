import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Stopwatch widget
class StopwatchWidget extends StatefulWidget {
  const StopwatchWidget({Key? key}) : super(key: key);

  @override
  StopwatchWidgetState createState() => StopwatchWidgetState();  // Perhatikan nama kelas tanpa _
}

class StopwatchWidgetState extends State<StopwatchWidget> {
  int seconds = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        seconds++;
      });
    });
  }

  void resetTimer() {
    setState(() {
      seconds = 0;
    });
  }

  String formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          formatTime(seconds),
          style: GoogleFonts.quicksand(
            textStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 3.0,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
