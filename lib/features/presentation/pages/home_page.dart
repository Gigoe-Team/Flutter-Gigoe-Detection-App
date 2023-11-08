import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigoe_detection_app/features/presentation/bloc/data_chart_bloc.dart';
import 'package:gigoe_detection_app/features/presentation/widgets/custom_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gigoe_detection_app/core/utils/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    context.read<DataChartBloc>().add(OnGetDataChartEvent());
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final List<String> images = [
      'assets/images/slider1.png',
      'assets/images/slider2.png',
      'assets/images/slider3.png',
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF3F9FB),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.contain,
              height: 40,
            ),
          ],
        ),
      ),
      body: SizedBox(
        height: screenHeight,
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: () {
                  context.read<DataChartBloc>().add(OnGetDataChartEvent());
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  width: MediaQuery.of(context).size.width / 1.12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: AppColors.softBlue,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Halo,',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Drg. Muhammad Fulan',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const CircleAvatar(radius: 30)
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            CarouselSlider(
              items: images.map((imagePath) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
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
                autoPlayInterval: const Duration(seconds: 5),
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                // onPageChanged: (index, reason) {
                //   if (kDebugMode) {
                //     print('Halaman berubah ke: $index');
                //   }
                // },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Data Statistik",
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Visualisasi data pengalaman karies dalam\nbentuk grafik berdasarkan wilayah dan\njumlah total gigi dmf dari semua pasien.",
                    style: GoogleFonts.poppins(
                        fontSize: 13, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: BlocBuilder<DataChartBloc, DataChartState>(
                builder: (context, state) {
                  if (state is DataChartHasData) {
                    return CustomChart(result: state.datas);
                  }
                  return const SizedBox();
                },
              ),
            ),
            // const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Keterangan:",
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "X = kode alamat berdasarkan kecamatan\nY = jumlah total gigi dmf dari semua pasien per kecamatan.",
                    style: GoogleFonts.poppins(
                        fontSize: 13, fontWeight: FontWeight.normal),
                  ),
                  Text(
                    "Kecamatan di Kota Banda Aceh:",
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "1. Baiturrahman (BN)\n2. Banda Raya (BR)\n3. Jaya Baru (JB)\n4. Kuta Alam (KA)\n5. Kuta Raja (KR)\n6. Lueng Bata (LB)\n7. Meuraxa (MX)\n8. Syiah Kuala (SK)\n9. Ulee Kareng (UK)",
                    style: GoogleFonts.poppins(
                        fontSize: 13, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
