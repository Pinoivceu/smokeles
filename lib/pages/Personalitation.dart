import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smokeless/services/firestore.dart'; // Import FirestoreService

class Personalitation extends StatefulWidget {
  const Personalitation({super.key});

  @override
  State<Personalitation> createState() => _PersonalitationState();
}

class _PersonalitationState extends State<Personalitation> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  DateTime? _birthDate; // Variabel untuk menyimpan tanggal lahir
  String _gender = 'laki laki';

  final FirestoreService _firestoreService = FirestoreService(); // Instansiasi FirestoreService

  // Fungsi untuk memilih tanggal lahir
  Future<void> _selectBirthDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000), // Tanggal default
      firstDate: DateTime(1900), // Batas awal tanggal
      lastDate: DateTime.now(), // Batas akhir tanggal
    );

    if (selectedDate != null) {
      setState(() {
        _birthDate = selectedDate;
      });
    }
  }

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
                textStyle: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFAA0810),
                ),
              ),
            ),
            const SizedBox(height: 20),
           
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(
                labelText: "nama depan",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(
                labelText: "nama belakang",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => _selectBirthDate(context), // Panggil Date Picker
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _birthDate == null
                          ? "Pilih tanggal lahir"
                          : "${_birthDate!.day}/${_birthDate!.month}/${_birthDate!.year}",
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    const Icon(Icons.calendar_today, color: Colors.grey),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _gender,
              decoration: InputDecoration(
                labelText: "Jenis kelamin",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              items: const [
                DropdownMenuItem(value: "laki laki", child: Text("Laki Laki")),
                DropdownMenuItem(value: "perempuan", child: Text("Perempuan")),
              ],
              onChanged: (value) {
                _gender = value!;
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFAA0810),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () async {
                  // Validasi input
                  if (_firstNameController.text.isEmpty ||
                      _lastNameController.text.isEmpty ||
                      _birthDate == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Semua field harus diisi!")),
                    );
                    return;
                  }

                  try {
                    // Panggil fungsi penyimpanan
                    await _firestoreService.saveUserProfile(
                      firstName: _firstNameController.text.trim(),
                      lastName: _lastNameController.text.trim(),
                      birthDate: "${_birthDate!.day}/${_birthDate!.month}/${_birthDate!.year}", // Format tanggal lahir
                      gender: _gender,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Data berhasil disimpan!")),
                    );

                    // Kosongkan field setelah sukses
                    _firstNameController.clear();
                    _lastNameController.clear();
                    setState(() {
                      _birthDate = null;
                    });

                    Navigator.pushReplacementNamed(context, '/personalitation1');
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error: $e")),
                    );
                  }
                },
                child: Text(
                  "Next",
                  style: GoogleFonts.quicksand(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
