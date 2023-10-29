import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nama = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: double.infinity,
              height: size.height - 450,
              decoration: const BoxDecoration(
                color: Color(0xffA0BEE0),
              ),
              child: Image.asset(
                'assets/images/doctor_register.png',
                height: 350,
                width: 360,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 360,
              height: 450,
              decoration: const ShapeDecoration(
                color: Color(0xFF4E73AF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Center(
                    child: Text(
                      'Daftar Akun',
                      style: GoogleFonts.poppins(
                          color: const Color(0xFFF3F9FB),
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      controller: nama,
                      decoration: InputDecoration(
                        hintText: 'Nama Lengkap',
                        hintStyle: GoogleFonts.poppins(
                            color: const Color(0xffC3C3C3),
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 10, 0, 10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                        hintText: 'Alamat Email',
                        hintStyle: GoogleFonts.poppins(
                            color: const Color(0xffC3C3C3),
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 10, 0, 10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      controller: password,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        hintText: 'Kata Sandi',
                        hintStyle: GoogleFonts.poppins(
                            color: const Color(0xffC3C3C3),
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.fromLTRB(20, 12, 0, 0),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility_rounded,
                              color: const Color(0xff2E4F4F),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    height: 40,
                    width: 230,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color(0xffffffff),
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .createUserWithEmailAndPassword(
                            email: email.text.trim(),
                            password: password.text.trim(),
                          );
                          // Get the user's unique ID
                          String userId = userCredential.user!.uid;
                          // Create a document reference for the user
                          DocumentReference userDocRef = FirebaseFirestore
                              .instance
                              .collection('users')
                              .doc(userId);
                          await userDocRef.set(
                            {
                              'name': nama.text.trim(),
                              'email': email.text.trim(),
                            },
                          );
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const LoginPage(),
                            ),
                          );
                        } catch (e) {
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Kesalahan',
                                      style: GoogleFonts.poppins(
                                          color: const Color.fromARGB(
                                              255, 0, 0, 0),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Data tidak boleh kosong atau data sudah terdaftar!',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                          color: const Color.fromARGB(
                                              255, 0, 0, 0),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    const SizedBox(height: 20),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(
                                            context); // Close the dialog
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xff0DAABC)),
                                      child: Text(
                                        'OK',
                                        style: GoogleFonts.poppins(
                                            color: const Color(0xffffffff),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Text(
                        'Buat Akun',
                        style: GoogleFonts.poppins(
                            color: const Color(0xFF4E73AF),
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Sudah mempunyai akun? ',
                          style: GoogleFonts.poppins(
                              color: const Color(0xffffffff),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                        TextSpan(
                          text: 'Masuk',
                          style: GoogleFonts.poppins(
                              color: const Color(0xFFF3F9FB),
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const LoginPage(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
