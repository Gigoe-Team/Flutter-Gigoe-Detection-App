import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo.png',
          height: 40,
          width: 180,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      // body: Stack(
      //   children: [
      //     Positioned(
      //       // Posisi Custom AppBar
      //       top: 0,
      //       left: 0,
      //       right: 0,
      //       child: Container(
      //         decoration: const BoxDecoration(
      //           borderRadius:
      //               BorderRadius.only(bottomRight: Radius.circular(30)),
      //           gradient: LinearGradient(
      //             colors: [Color(0xFF2E4F4F), Color(0xFF0E8388)],
      //             begin: Alignment.topCenter,
      //             end: Alignment.bottomCenter,
      //           ),
      //         ),
      //         height: 150,
      //         child: Stack(
      //           children: [
      //             Positioned(
      //               // Posisi Logo dalam Custom AppBar
      //               top: 50,
      //               left: 20,
      //               child: Image.asset(
      //                 'assets/images/appbar_logo.png',
      //                 width: 130,
      //                 height: 40,
      //               ),
      //             ),
      //             Positioned(
      //               // Posisi Teks dalam Custom AppBar
      //               bottom: 17,
      //               left: 20,
      //               child: Center(
      //                 child: RichText(
      //                   // Custom Teks
      //                   text: TextSpan(
      //                     text: 'Halo, ',
      //                     style: GoogleFonts.poppins(
      //                         color: const Color(0xffffffff),
      //                         fontSize: 16,
      //                         fontWeight: FontWeight.w400),
      //                     children: [
      //                       TextSpan(
      //                         text: 'Subhan Janura',
      //                         style: GoogleFonts.poppins(
      //                             color: const Color(0xffffffff),
      //                             fontSize: 16,
      //                             fontWeight: FontWeight.w600),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             ),
      //             Positioned(
      //               // Posisi Icon Profil Pengguna
      //               bottom: 10,
      //               right: 10,
      //               child: GestureDetector(
      //                 onTap: () {
      //                   Navigator.pushNamed(context,
      //                       '/profile-page'); // Ganti dengan rute halaman profil Anda
      //                 },
      //                 child: Image.asset(
      //                   'assets/icons/icon_profile.png',
      //                   width: 40,
      //                   height: 40,
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
