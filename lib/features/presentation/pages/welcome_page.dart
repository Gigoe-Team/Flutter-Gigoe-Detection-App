import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/custom_button.dart';
import 'login_page.dart';
import 'register_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Color(0xffF3F9FB),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 180,
              height: 40,
            ),
            const SizedBox(height: 20),
            Text(
              'Aplikasi Pemindai dan Pencatat Pengalaman Gigi Karies',
              style: GoogleFonts.poppins(
                  color: const Color(0xff000000),
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'Membantu dokter gigi dalam melakukan pemeriksaan dan pecatatan secara otomatis terhadap pengalaman gigi karies pada pasien',
              style: GoogleFonts.poppins(
                  color: const Color(0xffA0A0A0),
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Image.asset(
              'assets/images/dental.png',
              width: 293,
              height: 300,
            ),
            const SizedBox(height: 20),
            CustomButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const RegisterPage(),
                  ),
                );
              },
              btnText: "Daftar Akun",
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const LoginPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color(0xff000000),
                backgroundColor: const Color(0xFFFFFFFF),
                minimumSize: const Size(230, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    50,
                  ),
                ),
              ),
              child: Text(
                'Sudah mempunyai akun',
                style: GoogleFonts.poppins(
                    color: const Color(0xff4E73AF),
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
