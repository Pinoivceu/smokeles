import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StopwatchWidget extends StatefulWidget {
  const StopwatchWidget({super.key});

  @override
  StopwatchWidgetState createState() => StopwatchWidgetState();
}

class StopwatchWidgetState extends State<StopwatchWidget> {
  int seconds = 0;
  int cigarettesToday = 0;
  Timer? timer;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String userId;
  late DocumentReference _timerRef;
  DateTime? lastResetDate;

  @override
  void initState() {
    super.initState();
    userId = _auth.currentUser?.uid ?? 'default_user';
    _timerRef = FirebaseFirestore.instance.collection('users').doc(userId).collection('smoking_data').doc('timer');
    _loadTimer();
    startTimer();
    
  }

  // Mengambil data timer yang tersimpan di Firestore
  void _loadTimer() async {
    DocumentSnapshot snapshot = await _timerRef.get();
    if (snapshot.exists) {
      setState(() {
        seconds = snapshot['elapsed_time'] ?? 0;
        cigarettesToday = snapshot['cigarettes_today'] ?? 0;
        lastResetDate = (snapshot['last_reset_time'] as Timestamp?)?.toDate();


      });
      if (_isNewDay()) {
        _resetDailyData();
      }
    }
  }

  // Mengecek apakah hari ini sudah berbeda dengan hari terakhir reset
  bool _isNewDay() {
    if (lastResetDate == null) return true;
    DateTime currentDate = DateTime.now();
    return currentDate.year != lastResetDate!.year ||
        currentDate.month != lastResetDate!.month ||
        currentDate.day != lastResetDate!.day;
  }

  // Reset jumlah rokok yang dikonsumsi hari ini
  void _resetDailyData() {
    setState(() {
      cigarettesToday = 0;  // Reset rokok ke 0 untuk hari ini
    });
    _saveTimer(); // Simpan perubahan ke Firestore
  }

  // Menyimpan waktu yang telah berlalu ke Firestore
  void _saveTimer() {
    _timerRef.set({
      'elapsed_time': seconds,
      'last_updated': Timestamp.now(),
      'cigarettes_today': cigarettesToday,
      'last_reset_time': Timestamp.now(),
    }, SetOptions(merge: true)); // Merge data agar tidak menimpa yang lain
  }

  // Mulai timer dan update setiap detik
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        seconds++;
      });
      _saveTimer(); // Menyimpan waktu yang telah berlalu setiap detik
    });
  }

  // Reset timer dan simpan ke Firestore
  void resetTimer() {
    setState(() {
      seconds = 0;
      cigarettesToday++;
    });
    _timerRef.set({
      'elapsed_time': 0,
      'last_reset_time': Timestamp.now(),
      'cigarettes_today': cigarettesToday,
    }, SetOptions(merge: true)); // Reset dan simpan ke Firestore
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
