import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _dailyConsumptionController = TextEditingController();
  final TextEditingController _packPriceController = TextEditingController();
  final TextEditingController _perPackController = TextEditingController();

  Future<void> _saveUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('userName', _nameController.text);
    await prefs.setString('userGender', _genderController.text);
    await prefs.setInt('dailyCigaretteConsumption', int.parse(_dailyConsumptionController.text));
    await prefs.setDouble('cigarettePackPrice', double.parse(_packPriceController.text));
    await prefs.setInt('cigarettesPerPack', int.parse(_perPackController.text));
    await prefs.setBool('isFirstLaunch', false); // Tandai sebagai sudah pernah di-onboarding

    // Pindah ke halaman utama setelah menyimpan data
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hallo isi data di bawah ini"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Nama"),
            ),
            TextField(
              controller: _genderController,
              decoration: InputDecoration(labelText: "Jenis Kelamin"),
            ),
            TextField(
              controller: _dailyConsumptionController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Jumlah Rokok per Hari"),
            ),
            TextField(
              controller: _packPriceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Harga per Bungkus"),
            ),
            TextField(
              controller: _perPackController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Batang per Bungkus"),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _saveUserData,
                child: Text("Simpan"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
