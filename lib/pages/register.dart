import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smokeless/pages/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      backgroundColor: Colors.white, // Warna background halaman
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 100,),
                // Gambar/logo
                Text('Create Account',style: GoogleFonts.quicksand(
    textStyle: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Color(0xFFAA0810), // Warna isi teks,
                ),)),                
                const SizedBox(height: 25), // Jarak antar logo dan form login
                Text('For new healty life without smoke',
                style: GoogleFonts.quicksand(
    textStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,),)),
                const SizedBox(height: 75), // Jarak antar logo dan form login

                // Form input email
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: GoogleFonts.quicksand(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),

                SizedBox(height: 20), // Jarak antar input
                
                // Form input password
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: GoogleFonts.quicksand(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
                                SizedBox(height: 20), // Jarak antar input

                TextField(
  controller: _confirmPasswordController,
  obscureText: true,
  decoration: InputDecoration(
    labelText: 'Confirm Password',
    labelStyle: GoogleFonts.quicksand(),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    prefixIcon: Icon(Icons.lock),
  ),
),
                
                SizedBox(height: 40), // Jarak antar input dan tombol
                
                // Tombol login
                ElevatedButton(
                  onPressed: (_register),
                  
                    // Logika login bisa ditambahkan di sin
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 140),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Color(0xFFAA0810), // Warna tombol
                  ),
                  child: isLoading
      ? CircularProgressIndicator(
          color: Colors.black, // Warna loading indicator
        )
                 : Text(
                    'Register',
                    style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                
                SizedBox(height: 20), // Jarak antara tombol login dan link ke halaman registrasi

                // Link ke halaman registrasi
                TextButton(
                  onPressed: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                    // Logika untuk navigasi ke halaman registrasi
                  },
                  child: Text(
                    'Sudah punya akun? Login',
                    style: GoogleFonts.quicksand(
                      color: Color(0xFFAA0810),
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _register() async {
    
  // Validasi apakah password dan confirm password cocok
  if (_passwordController.text != _confirmPasswordController.text) {
    // Tampilkan pesan error jika password dan confirm password tidak cocok
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Password not match')),
    );
    return; // Hentikan proses jika password tidak cocok
  }
 setState(() {
      isLoading = true; // Mulai loading saat tombol ditekan
    });
  try {
    // Jika password dan confirm password cocok, lanjutkan registrasi
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );
  
    
    // Arahkan ke halaman personalisasi setelah registrasi berhasil
    Navigator.pushReplacementNamed(context, '/personalitation');
  } catch (e) {
    // Tampilkan error jika registrasi gagal
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Registration failed: $e')),
    );
  }
}
}

