import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GuidePage extends StatefulWidget {
  const GuidePage({super.key});

  @override
  State<GuidePage> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.softWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        backgroundColor: AppColors.softWhite,
        elevation: 0,
        toolbarHeight: 80,
        title: Text(
          "Panduan Penggunaan",
          style: GoogleFonts.poppins(
              color: AppColors.primaryBlue,
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 40),
          CarouselSlider(
            items: [
              _buildPhotoSlide(
                  "Foto 1 - Gigi Labial", "assets/images/gigi_depan.JPG"),
              _buildPhotoSlide(
                  "Foto 2 - Gigi Bukal Kanan", "assets/images/gigi_kanan.JPG"),
              _buildPhotoSlide(
                  "Foto 3 - Gigi Bukal Kiri", "assets/images/gigi_kiri.JPG"),
              _buildPhotoSlide(
                  "Foto 4 - Gigi Oklusal Atas", "assets/images/gigi_atas.JPG"),
              _buildPhotoSlide(
                  "Foto 5 - Gigi Oklusal Bawah", "assets/images/gigi_bawah.JPG")
            ],
            options: CarouselOptions(
              height: height * 0.43,
              disableCenter: true,
              initialPage: 0,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
              onPageChanged: (index, reason) {
                if (kDebugMode) {
                  print('Halaman berubah ke: $index');
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Text(
                  '1. Buka mulut pasien dengan lebar seperti pada contoh diatas!\n2. Arahkan kamera ke mulut pasien.\n3. Tekan layar atau tekan tombol volume untuk mengambil foto.',
                  style: GoogleFonts.poppins(
                      color: const Color(0xff000000),
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildPhotoSlide(
  String title,
  String assetPath,
) {
  return Container(
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                    color: const Color(0xff000000),
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        Center(
          child: SizedBox(
            height: 240,
            width: 240,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                image: AssetImage(assetPath),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
