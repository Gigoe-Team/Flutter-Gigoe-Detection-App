import '../../../Firebase/fetch_data_pasien.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.softWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        elevation: 0,
        toolbarHeight: 80,
        title: Text(
          "Daftar Riwayat Pasien",
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
      body: SizedBox(
        height: screenHeight,
        child: const Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 80),
            child: FetchDataResults(),
          ),
        ),
      ),
    );
  }
}
