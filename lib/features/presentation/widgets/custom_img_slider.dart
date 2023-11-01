import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomImgSlider extends StatelessWidget {
  // Daftar gambar untuk Carousel Slider
  final List<String> images = [
    'assets/images/slider1.png',
    'assets/images/slider2.png',
    'assets/images/slider3.png',
    // Tambahkan path gambar di sini
  ];

  CustomImgSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.only(top: 200),
        child: CarouselSlider(
          items: images.map((imagePath) {
            return Container(
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            height: 150,
            initialPage: 0,
            autoPlay: true,
            autoPlayInterval:
                const Duration(seconds: 5), // Waktu bergeser otomatis
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            onPageChanged: (index, reason) {
              if (kDebugMode) {
                print('Halaman berubah ke: $index');
              }
            },
          ),
        ),
      ),
      // body: Stack(
      //   children: [
      //     Positioned(
      //       // Posisi Carousel Slider
      //       top: 180,
      //       left: 0,
      //       right: 0,
      //       child: CarouselSlider(
      //         items: images.map((imagePath) {
      //           return Container(
      //             margin: const EdgeInsets.all(5.0),
      //             decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(8.0),
      //               image: DecorationImage(
      //                 image: AssetImage(imagePath),
      //                 fit: BoxFit.cover,
      //               ),
      //             ),
      //           );
      //         }).toList(),
      //         options: CarouselOptions(
      //           height: 150,
      //           initialPage: 0,
      //           autoPlay: true,
      //           autoPlayInterval:
      //               const Duration(seconds: 5), // Waktu bergeser otomatis
      //           enlargeCenterPage: true,
      //           enableInfiniteScroll: true,
      //           onPageChanged: (index, reason) {
      //             if (kDebugMode) {
      //               print('Halaman berubah ke: $index');
      //             }
      //           },
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
