import 'package:flutter/material.dart';
import 'package:gigoe_detection_app/core/utils/app_colors.dart';
import 'package:gigoe_detection_app/features/presentation/pages/add_patient_page.dart';
import 'package:gigoe_detection_app/features/presentation/pages/guide_page.dart';
import 'package:gigoe_detection_app/features/presentation/pages/history_page.dart';
import 'package:gigoe_detection_app/features/presentation/pages/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

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
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Widget buildButtonBar() {
      return WillPopScope(
        onWillPop: _onBackPressed,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: const EdgeInsets.all(10),
            height: size.width * .170,
            decoration: BoxDecoration(
              color: AppColors.primaryBlue,
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
                        color: AppColors.darkBlue,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(10),
                        ),
                      ),
                    ),
                    Icon(
                      listOfIcon[index],
                      size: size.width * .076,
                      color: index == currentIndex
                          ? AppColors.darkBlue
                          : AppColors.softWhite,
                    ),
                    SizedBox(height: size.width * .03),
                  ],
                ),
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
  }

  List<IconData> listOfIcon = [
    Icons.home_rounded,
    Icons.menu_book_rounded,
    Icons.add_box_rounded,
    Icons.history_rounded,
  ];

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.softWhite,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        title: Text(
          'Konfirmasi Keluar',
          style: GoogleFonts.poppins(
              color: const Color.fromARGB(255, 0, 0, 0),
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
        content: Text(
          'Apakah Anda yakin ingin keluar dari aplikasi Gigoe Detection?',
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
                  fontWeight: FontWeight.w500),
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
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    ).then((value) => value ?? false);
  }
}
