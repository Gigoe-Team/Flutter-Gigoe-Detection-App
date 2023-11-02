import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../pages/add_patient_page.dart';
import '../pages/guide_page.dart';
import '../pages/history_page.dart';
import '../pages/home_page.dart';
// import '../pages/profile_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavBar createState() => _BottomNavBar();
}

class _BottomNavBar extends State<BottomNavBar> {
  var currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const GuidePage(),
    const AddPatient(),
    const HistoryPage(),
    // const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Widget buildButtonBar() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.all(10),
          height: size.width * .170,
          decoration: BoxDecoration(
            color: const Color(0xFF4E73AF),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListView.builder(
            itemCount: 4,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(
              horizontal: size.width * .024,
            ),
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                setState(
                  () {
                    currentIndex = index;
                  },
                );
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 2000),
                    curve: Curves.fastLinearToSlowEaseIn,
                    margin: EdgeInsets.only(
                      bottom: index == currentIndex ? 0 : size.width * .029,
                      right: size.width * .0422,
                      left: size.width * .0422,
                    ),
                    width: size.width * .128,
                    height: index == currentIndex ? size.width * .014 : 0,
                    decoration: const BoxDecoration(
                      color: Color(0xff1C3557),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(10),
                      ),
                    ),
                  ),
                  Icon(
                    listOfIcon[index],
                    size: size.width * .076,
                    color: index == currentIndex
                        ? const Color(0xff1C3557)
                        : Colors.white,
                  ),
                  SizedBox(height: size.width * .03),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          _pages[currentIndex],
          buildButtonBar(),
        ],
      ),
    );

    // return WillPopScope(
    //   onWillPop: _onBackPressed,
    //   child: Scaffold(
    //     body: _pages[_currentIndex],
    //     bottomNavigationBar: BottomNavigationBar(
    //       currentIndex: _currentIndex,
    //       onTap: (index) {
    //         setState(
    //           () {
    //             _currentIndex = index;
    //           },
    //         );
    //       },
    //       items: const [
    //         BottomNavigationBarItem(
    //           icon: Icon(Icons.home_rounded),
    //           label: 'Beranda',
    //           backgroundColor: Color(0xff0e8388),
    //         ),
    //         BottomNavigationBarItem(
    //           icon: Icon(Icons.menu_book_rounded),
    //           label: 'Panduan',
    //           backgroundColor: Color(0xff0e8388),
    //         ),
    //         BottomNavigationBarItem(
    //           icon: Icon(Icons.add_box_rounded),
    //           label: 'Tambahkan',
    //           backgroundColor: Color(0xff0e8388),
    //         ),
    //         BottomNavigationBarItem(
    //           icon: Icon(Icons.history_rounded),
    //           label: 'Riwayat',
    //           backgroundColor: Color(0xff0e8388),
    //         ),
    //         // BottomNavigationBarItem(
    //         //   icon: Icon(Icons.person_rounded),
    //         //   label: 'Profil',
    //         //   backgroundColor: Color(0xff0e8388),
    //         // ),
    //       ],
    //     ),
    //   ),
    // );
  }

  List<IconData> listOfIcon = [
    Icons.home_rounded,
    Icons.menu_book_rounded,
    Icons.add_box_rounded,
    Icons.history_rounded,
  ];

  // ignore: unused_element
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
