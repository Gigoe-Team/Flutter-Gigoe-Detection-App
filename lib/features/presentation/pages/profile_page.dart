import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffCBE4DE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 80,
        title: Text(
          "Profil Pengguna",
          style: GoogleFonts.poppins(
            color: const Color(0xffffffff),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 130,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                      width: 60,
                      height: 60,
                      child: Image.asset('assets/icons/icon_profile.png'),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Subhan Janura",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.phone,
                              size: 20,
                              color: Color(0xff0E8388),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "085212345678",
                              style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.credit_card,
                              size: 20,
                              color: Color(0xff0E8388),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "1173031234567890",
                              style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Informasi",
                style: GoogleFonts.poppins(
                    color: const Color(0xff2E4F4F),
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              width: 300,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 20),
                      const Icon(
                        Icons.chat_rounded,
                        size: 20,
                        color: Color(0xff0E8388),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        "FAQ",
                        style: GoogleFonts.poppins(
                            color: Colors.black, fontSize: 14),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Color(0xffA1D0D2),
                    thickness: 2,
                    height: 20,
                    indent: 20,
                    endIndent: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 20),
                      const Icon(
                        Icons.menu_book_rounded,
                        size: 20,
                        color: Color(0xff0E8388),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        "Tentang Kami",
                        style: GoogleFonts.poppins(
                            color: Colors.black, fontSize: 14),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Preferensi",
                style: GoogleFonts.poppins(
                    color: const Color(0xff2E4F4F),
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              width: 300,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 20),
                      const Icon(
                        Icons.translate_rounded,
                        size: 20,
                        color: Color(0xff0E8388),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        "Bahasa",
                        style: GoogleFonts.poppins(
                            color: Colors.black, fontSize: 14),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Color(0xffA1D0D2),
                    thickness: 2,
                    height: 20,
                    indent: 20,
                    endIndent: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 20),
                      const Icon(
                        Icons.logout_rounded,
                        size: 20,
                        color: Color(0xff0E8388),
                      ),
                      const SizedBox(width: 20),
                      InkWell(
                        child: SizedBox(
                          width: 200,
                          child: Text(
                            "Keluar",
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 14),
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/signIn-page', (route) => false);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
