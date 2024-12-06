import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'register.dart';
import 'package:smokeless/services/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;
  bool isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
        setState(() {
      isLoading = true; // Set loading ke true saat login dimulai
    });
    try {
      await Auth().signInWithEmailAndPassword(
        email: _emailController.text, 
        password: _passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
        isLoading = false;
      });
    }
  }
  

  Future<void> createUserWithEmailAndPassword() async {
        setState(() {
      isLoading = true; // Set loading ke true saat login dimulai
    });
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _emailController.text, 
        password: _passwordController.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
                Text('Login Here!',style: GoogleFonts.quicksand(
    textStyle: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Color(0xFFAA0810), // Warna isi teks,
                ),)),                
                const SizedBox(height: 25), // Jarak antar logo dan form login
                Text('Welcome Back You`ve been missed',
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
                
                SizedBox(height: 40), // Jarak antar input dan tombol
                
                // Tombol login
                ElevatedButton(
                  onPressed: (_login),
                  
                    // Logika login bisa ditambahkan di sin
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: screenWidth * 0.4),
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
                    'Login',
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
                      MaterialPageRoute(builder: (context) => const RegisterPage()),
                    );
                    // Logika untuk navigasi ke halaman registrasi
                  },
                  child: Text(
                    'Belum punya akun? Daftar',
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
  Future<void> _login() async {
    setState(() {
      isLoading = true; // Mulai loading saat tombol ditekan
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      print('Login Successful');
      // Arahkan ke halaman utama setelah login berhasil
      Navigator.pushReplacementNamed(context, '/Home');
    } catch (e) {
      print('Login Error: $e');
    }
  }
}



