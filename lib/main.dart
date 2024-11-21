import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smokeless/pages/Home.dart';
import 'package:smokeless/pages/onboarding.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smokeless',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<bool>(
        future: _isFirstLaunch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            return snapshot.data! ? const OnboardingPage() : const Home();
          }
        },
      ),
      routes: {
        '/home': (context) => const Home(),
        '/onboarding': (context) => const OnboardingPage(),
      },
    );
  }

  // Fungsi untuk memeriksa apakah ini adalah peluncuran pertama
  Future<bool> _isFirstLaunch() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isFirstLaunch') ?? true;
  }
}
