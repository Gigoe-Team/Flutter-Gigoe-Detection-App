import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/data_chart_bloc.dart';
import '../widgets/custom_chart.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/utils/app_colors.dart';

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
    final List<String> images = [
      'assets/images/slider1.png',
      'assets/images/slider2.png',
      'assets/images/slider3.png',
    ];

    return Scaffold(
      backgroundColor: const Color(0xffCBE4DE),
      appBar: AppBar(
        forceMaterialTransparency: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
            ),
            gradient: LinearGradient(
              colors: [
                Color(0xff2E4F4F),
                Color(0xff0E8388),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: ListView(
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
                  color: AppColors.kBlueColor,
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
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'Drg. Muhammad Fulan,',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
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
              autoPlayInterval: const Duration(seconds: 5),
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
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
                  "Hasil Perhitungan Pengalaman Karies dalam\nbentuk Grafik berdasarkan jumlah Pasien,\nWilayah dan gender.",
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
                  print(state);
                  return CustomChart(result: state.datas);
                }
                return const SizedBox();
              },
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
