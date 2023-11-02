import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Firebase/fetch_data_pasien.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F9FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 80,
        title: Text(
          "Daftar Riwayat Pasien",
          style: GoogleFonts.poppins(
              color: const Color(0xFF4E73AF),
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
            // gradient: LinearGradient(
            //   colors: [
            //     Color(0xff2E4F4F),
            //     Color(0xff0E8388),
            //   ],
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            // ),
          ),
        ),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
          child: FetchDataResults(),
        ),
      ),
    );
  }
}
