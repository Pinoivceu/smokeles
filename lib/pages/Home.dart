import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smokeless/components/stopwatch.dart'; 
import 'package:smokeless/components/carousel.dart';
import 'package:smokeless/styles/app-text-styles.dart';
import 'package:smokeless/pages/comunity.dart';
import 'package:smokeless/pages/profile.dart';
import 'package:smokeless/services/firestore.dart';// Pastikan import stopwatch dari components

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

final GlobalKey<StopwatchWidgetState> stopwatchKey = GlobalKey<StopwatchWidgetState>();

  // Daftar halaman untuk navigasi
  final List<Widget> _pages = [
    const HomeContent(),   // Konten utama halaman Home
    const Community(),     // Halaman Community
    const Profile(),       // Halaman Profile
  ];

  // Fungsi untuk memperbarui indeks saat tombol dinavigasi ditekan
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Menampilkan halaman berdasarkan pilihan pengguna
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFAA0810),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
  //final GlobalKey<StopwatchWidgetState> stopwatchKey = GlobalKey<StopwatchWidgetState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFAA0810), // Warna AppBar
        title:FutureBuilder<Map<String, dynamic>?>(
          future: FirestoreService().fetchUserProfile(),  // Memanggil fungsi fetchUserProfile() untuk mengambil data pengguna
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Hello, User!', style: TextStyle(color: Colors.white));
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}", style: const TextStyle(color: Colors.white));
            } else if (!snapshot.hasData) {
              return const Text("Hello, User!", style: TextStyle(color: Colors.white));
            } else {
              var userData = snapshot.data!;
              String firstName = userData['first_name'] ?? "User";
              return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Hello, $firstName !', style: AppTextStyles.headline),
            Row(
              children: [
                IconButton(
                  iconSize: 28,
                  icon: Icon(Icons.notifications),
                  color: Colors.white,
                  onPressed: () {
                    
                  },
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 18,
                  child: Text('US'),
                ),
              ],
            ),
          ],
        );
          }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              width: screenWidth ,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                image: DecorationImage(
                  image: AssetImage('assets/images/background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Time Smoke Free',
                    style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                 // StopwatchWidget(key: stopwatchKey),
                  Text(
                    'Jam Menit Detik',
                    style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 3.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            Container(
              width: screenWidth ,
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xFFAA0810),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '',
                    style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 60,),
                  FilledButton(
                    onPressed: () {
                      FirestoreService().incrementCigarettesToday();
                     
                      
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    child: Text(
                      'Im Smoke',
                      style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black, // Warna isi teks
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.all(5)),
            Container(
              width: screenWidth ,
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xFF116200),
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Saved: Rp. 10,11',
                  style: AppTextStyles.h2WithFill,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(5)),
            Container(
              width: screenWidth,
              height: 100,
              decoration: BoxDecoration(
                color: Color(0xFFAA0810),
                border: Border.all(color: Colors.black,
                width: 2.0),
                borderRadius: BorderRadius.circular(10),
              ),
              child: StreamBuilder<List<Map<String, dynamic>>>(
  stream: FirestoreService().fetchSmokingData(),  // Memanggil stream dari fetchSmokingDataToday
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    }

    if (snapshot.hasError) {
      return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
    }

    if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return Center(child: Text('Tidak ada data untuk hari ini dan kemarin'));
    }

    List<Map<String, dynamic>> data = snapshot.data!;

    // Filter untuk data hari ini dan kemarin
    String today = "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";
    String yesterday = "${DateTime.now().subtract(Duration(days: 1)).year}-${DateTime.now().subtract(Duration(days: 1)).month}-${DateTime.now().subtract(Duration(days: 1)).day}";

    // Memisahkan data hari ini dan kemarin
    List<Map<String, dynamic>> todayData = data.where((item) => item['tanggal'] == today).toList();
    List<Map<String, dynamic>> yesterdayData = data.where((item) => item['tanggal'] == yesterday).toList();
    int todayCount = todayData.isNotEmpty ? todayData[0]['count'] ?? 0 : 0;
    int yesterdayCount = yesterdayData.isNotEmpty ? yesterdayData[0]['count'] ?? 0 : 0;
    int reduceCount = yesterdayCount - todayCount;


  

      return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Today smoke',
                      style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                      ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30,
                  child: Text('$todayCount',
                      style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                      ),
                ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Yesterday',
                      style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                      ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30,
                  child: Text('$yesterdayCount',
                      style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                      ),
                ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Reduce',
                      style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                      ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30,
                  child: Text('$reduceCount',
                      style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                      ),
                ),
                    ],
                  ),
                ],
              );
  }),),
            Padding(padding: EdgeInsets.all(5)),
           Carousel(
                textList: [
              'Berhenti merokok tidak hanya menyelamatkan Anda, tetapi juga keluarga Anda dari paparan asap berbahaya.',
              'Setiap batang rokok yang Anda hindari adalah langkah menuju hidup yang lebih sehat dan panjang untuk bersama keluarga.',
              'Ingatlah, kesehatan Anda adalah hadiah terbaik untuk keluarga yang mencintai Anda.',
              'Menjauhkan diri dari rokok membantu menciptakan lingkungan yang lebih sehat untuk anak-anak dan orang tersayang.',
              'Berhenti merokok adalah langkah penting untuk menjadi contoh yang baik bagi generasi mendatang.',
                ])
        ],
        ),
      ),
     
    );
  }
}
