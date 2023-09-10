import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../pages/add_patient_page.dart';
import '../pages/guide_page.dart';
import '../pages/history_page.dart';
import '../pages/home_page.dart';
import '../pages/profile_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavBar createState() => _BottomNavBar();
}

class _BottomNavBar extends State<BottomNavBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const GuidePage(),
    const AddPatient(),
    const HistoryPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(
              () {
                _currentIndex = index;
              },
            );
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Beranda',
              backgroundColor: Color(0xff0e8388),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_rounded),
              label: 'Panduan',
              backgroundColor: Color(0xff0e8388),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box_rounded),
              label: 'Tambahkan',
              backgroundColor: Color(0xff0e8388),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history_rounded),
              label: 'Riwayat',
              backgroundColor: Color(0xff0e8388),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Profil',
              backgroundColor: Color(0xff0e8388),
            ),
          ],
        ),
      ),
    );
  }
  // Widget build(BuildContext context) {
  //   return WillPopScope(
  //     onWillPop: _onBackPressed,
  //     child: Scaffold(
  //       body: _pages[_currentIndex],
  //       bottomNavigationBar: BottomNavigationBar(
  //         currentIndex: _currentIndex,
  //         onTap: (index) {
  //           setState(
  //             () {
  //               _currentIndex = index;
  //             },
  //           );
  //         },
  //         items: const [
  //           BottomNavigationBarItem(
  //             icon: Icon(Icons.home_rounded),
  //             label: 'Beranda',
  //             backgroundColor: Color(0xff0e8388),
  //           ),
  //           BottomNavigationBarItem(
  //             icon: Icon(Icons.menu_book_rounded),
  //             label: 'Panduan',
  //             backgroundColor: Color(0xff0e8388),
  //           ),
  //           BottomNavigationBarItem(
  //             icon: Icon(Icons.add_box_rounded),
  //             label: 'Tambahkan',
  //             backgroundColor: Color(0xff0e8388),
  //           ),
  //           BottomNavigationBarItem(
  //             icon: Icon(Icons.history_rounded),
  //             label: 'Riwayat',
  //             backgroundColor: Color(0xff0e8388),
  //           ),
  //           BottomNavigationBarItem(
  //             icon: Icon(Icons.person_rounded),
  //             label: 'Profil',
  //             backgroundColor: Color(0xff0e8388),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Konfirmasi Keluar',
          style: GoogleFonts.poppins(
              color: const Color.fromARGB(255, 0, 0, 0),
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
        content: Text(
          'Anda yakin ingin keluar dari aplikasi Gigoe Detection?',
          style: GoogleFonts.poppins(
              color: const Color.fromARGB(255, 0, 0, 0),
              fontSize: 14,
              fontWeight: FontWeight.w400),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'Tidak',
              style: GoogleFonts.poppins(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: 14,
                  fontWeight: FontWeight.normal),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: Colors.red[900],
              textStyle: GoogleFonts.poppins(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
            child: Text(
              'Keluar',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    ).then((value) => value ?? false);
  }
}
