import 'package:flutter/material.dart';
import 'package:smokeless/services/firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class SmokingProfilePage extends StatelessWidget {
  final TextEditingController _cigarettesPerDayController =
      TextEditingController();
  final TextEditingController _pricePerPackController = TextEditingController();
  final TextEditingController _cigarettesPerPackController = TextEditingController();

  SmokingProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
     
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text(
              "Set Up Your Profile",
              style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFAA0810)
                      ),
                    ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _cigarettesPerDayController,
              decoration: InputDecoration(
                labelText: "rokok dalam 1 hari",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
           TextField(
              controller: _cigarettesPerPackController,
              decoration: InputDecoration(
                labelText: "Banyak rokok per 1 bungkus",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _pricePerPackController,
              decoration: InputDecoration(
                labelText: "harga rokok 1 bungkus",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child:ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: Color(0xFFAA0810),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    padding: const EdgeInsets.symmetric(vertical: 16),
  ),
  onPressed: () async {
  if (_cigarettesPerDayController.text.isEmpty ||
      _pricePerPackController.text.isEmpty || _cigarettesPerPackController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Semua field harus diisi!")),
    );
    return;
  }

  try {
    // Create an instance of FirestoreService
    FirestoreService firestoreService = FirestoreService();

    // Call the instance method
    await firestoreService.saveSmokingData(
      cigarettesPerDay: int.parse(_cigarettesPerDayController.text),
      pricePerPack: int.parse(_pricePerPackController.text),
      cigarettesPerPack: int.parse(_cigarettesPerPackController.text)
    );
    await firestoreService.saveSmokingHistory(cigarettesToday: 0);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Data berhasil disimpan!")),
    );

    _cigarettesPerDayController.clear();
    _pricePerPackController.clear();
    _cigarettesPerPackController.clear();

    Navigator.pushReplacementNamed(context, '/');
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: $e")),
    );
  }
},
  child: Text(
    "Register",
    style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
  ),
)

            ),
          ],
        ),
      ),
    );
  }
}
