import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Community extends StatelessWidget {
  const Community({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFAA0810), // Warna AppBar
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 18,
              child: Text('US'),
            ),
            IconButton(
              iconSize: 28,
              icon: Icon(Icons.notifications),
              color: Colors.white,
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          // SliverAppBar yang sticky dengan konten "Untuk Anda" dan "Mengikuti"
          SliverAppBar(
            backgroundColor: Colors.white,
            pinned: true,
            toolbarHeight: 50,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Untuk Anda',
                  style: GoogleFonts.quicksand(
                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
                Text(
                  'Mengikuti',
                  style: GoogleFonts.quicksand(
                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          
          // ListView builder untuk postingan
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  width: screenWidth * 0.9,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // Shadow position
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: 10,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Pino',
                            style: GoogleFonts.quicksand(
                              textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                      Text(
                        'Sudah ${index + 1}0 hari saya berhenti, saya suka sekali wkwkwkwk',
                        style: GoogleFonts.quicksand(
                          textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                        ),
                      ),
                      // Area untuk foto
                      Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                      Center(
                        child: Container(
                          width: screenWidth * 0.8, // Ukuran lebar foto
                          height: 200, // Ukuran tinggi foto
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(
                                'https://via.placeholder.com/150', // Ganti dengan URL foto
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                );
              },
              childCount: 10, // Jumlah postingan
            ),
          ),
        ],
      ),
     
    );
  }
}
