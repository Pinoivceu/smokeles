import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color(0xFFAA0810), // Warna AppBar
      ),
      body: Center(
        child: Text(
          'This is the Profile Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
