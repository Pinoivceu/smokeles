import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

class Carousel extends StatefulWidget {
  final List<String> textList;

  const Carousel({super.key, required this.textList});

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width ,
          decoration: BoxDecoration(
            color: Color(0xFFFFF5F0),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.black,
              width: 2.0,
            ),
          ),
          child: CarouselSlider(
            options: CarouselOptions(
              height: 150.0,
              autoPlay: true,
              enlargeCenterPage: true,
              autoPlayInterval: Duration(seconds: 3),
              viewportFraction: 1.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: widget.textList.map((text) {
              return Builder(
                builder: (BuildContext context) {
                  return Center(
                    child: Text(
                      text,
                      style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
        Positioned(
          top: 8.0,
          left: 8.0,
          child: Row(
            children: List.generate(3, (index) {
              int dotIndex = (_currentIndex - 1 + index) % widget.textList.length;
              return Row(
                children: [
                  Container(
                    width: 10.0,
                    height: 10.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: dotIndex == _currentIndex ? Colors.black : Colors.grey,
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                  ),
                  SizedBox(width: 6.0),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}
