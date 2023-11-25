import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gigoe_detection_app/core/utils/app_colors.dart';
import 'package:gigoe_detection_app/features/presentation/widgets/user_model.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loginUser = UserModel();
  late String _userName = '';
  @override
  void initState() {
    super.initState();
    _fetchUserName();
    setState(() {});
  }

  void _fetchUserName() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userDoc =
          FirebaseFirestore.instance.collection('users').doc(user.uid);
      final userData = await userDoc.get();
      if (userData.exists) {
        setState(() {
          _userName = userData.get('name') ?? '';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColors.primaryBlue),
        ),
        elevation: 0,
        toolbarHeight: 80,
        title: Text(
          "Profil Pengguna",
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
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              // width: 300,
              height: 130,
              decoration: BoxDecoration(
                color: AppColors.darkBlue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                margin: const EdgeInsets.only(left: 50),
                child: Row(
                  children: [
                    // Container(
                    //   margin: const EdgeInsets.all(20),
                    //   child: const CircleAvatar(
                    //     backgroundColor: AppColors.softWhite,
                    //     radius: 30,
                    //     child: Icon(
                    //       Icons.person,
                    //       size: 40,
                    //       color: AppColors.darkBlue,
                    //     ),
                    //   ),
                    // ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'drg. $_userName',
                          style: GoogleFonts.poppins(
                            color: AppColors.softWhite,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 0),
                        Text(
                          "NPA 0102.030806",
                          style: GoogleFonts.poppins(
                            color: AppColors.softWhite,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 0),
                        Row(
                          children: [
                            const Icon(
                              Icons.email,
                              size: 20,
                              color: AppColors.softWhite,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "email_saya@gmail.com",
                              style: GoogleFonts.poppins(
                                color: AppColors.softWhite,
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
                    color: AppColors.darkBlue,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              width: 300,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.primaryBlue,
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
                        color: AppColors.softWhite,
                      ),
                      const SizedBox(width: 20),
                      Text(
                        "FAQ",
                        style: GoogleFonts.poppins(
                          color: AppColors.softWhite,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: AppColors.softBlue,
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
                        color: AppColors.softWhite,
                      ),
                      const SizedBox(width: 20),
                      Text(
                        "Tentang Kami",
                        style: GoogleFonts.poppins(
                          color: AppColors.softWhite,
                          fontSize: 14,
                        ),
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
                    color: AppColors.darkBlue,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              width: 300,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.primaryBlue,
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
                        color: AppColors.softWhite,
                      ),
                      const SizedBox(width: 20),
                      Text(
                        "Bahasa",
                        style: GoogleFonts.poppins(
                          color: AppColors.softWhite,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: AppColors.softBlue,
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
                        color: AppColors.softWhite,
                      ),
                      const SizedBox(width: 20),
                      InkWell(
                        child: SizedBox(
                          width: 200,
                          child: Text(
                            "Keluar Akun",
                            style: GoogleFonts.poppins(
                              color: AppColors.softWhite,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.warning,
                                            color: Colors.red[900],
                                          ),
                                          const SizedBox(width: 10),
                                          Text("Konfirmasi!",
                                              style: GoogleFonts.poppins(
                                                color: Colors.red[900],
                                              )),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        "Anda yakin ingin keluar dari akun?",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          child: Text(
                                            "Batal",
                                            style: GoogleFonts.poppins(
                                              color: AppColors.primaryBlue,
                                              fontSize: 14,
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                '/welcome',
                                                (route) => false);
                                          },
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.red[900],
                                            textStyle: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 14,
                                            ),
                                          ),
                                          child: const Text('Ya'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
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
