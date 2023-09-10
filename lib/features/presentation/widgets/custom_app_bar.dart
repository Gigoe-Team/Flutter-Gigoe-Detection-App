import 'dart:ui';

import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  GlobalKey globalKey = GlobalKey();

  void showMyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: const Color(0xffCBE4DE),
          title: Text(
            'Scan QR Code!',
            textAlign: TextAlign.center,
            style:
                GoogleFonts.poppins(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RepaintBoundary(
                key: globalKey,
                child: QrImageView(
                  data: 'https://wa.me/6285262820401',
                  backgroundColor: const Color(0xff2E4F4F),
                  // ignore: deprecated_member_use
                  foregroundColor: const Color(0xffffffff),
                  version: QrVersions.auto,
                  size: 200,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 50),
                  foregroundColor: const Color(0xff0E8388),
                  backgroundColor: const Color(0xffffffff),
                  padding: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 2,
                ),
                onPressed: () async {
                  await shareQrCodeImage();
                },
                child: Text(
                  'Bagikan QR Code?',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> shareQrCodeImage() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 3);
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List? uint8List = byteData?.buffer.asUint8List();

      await Share.file('QR Code', 'qr_code.png', uint8List!, 'image/png',
          text: 'Subhan Janura | WhatsApp | 085262820401');
    } catch (e) {
      if (kDebugMode) {
        print('Error sharing QR Code: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned(
            // Posisi Custom AppBar
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(30)),
                gradient: LinearGradient(
                  colors: [Color(0xFF2E4F4F), Color(0xFF0E8388)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              height: 150,
              child: Stack(
                children: [
                  Positioned(
                    // Posisi Logo dalam Custom AppBar
                    top: 50,
                    left: 20,
                    child: Image.asset(
                      'assets/images/appbar_logo.png',
                      width: 130,
                      height: 40,
                    ),
                  ),
                  Positioned(
                    // Posisi Teks dalam Custom AppBar
                    bottom: 17,
                    left: 20,
                    child: Center(
                      child: RichText(
                        // Custom Teks
                        text: TextSpan(
                          text: 'Halo, ',
                          style: GoogleFonts.poppins(
                              color: const Color(0xffffffff),
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                          children: [
                            TextSpan(
                              text: 'Subhan Janura',
                              style: GoogleFonts.poppins(
                                  color: const Color(0xffffffff),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    // Posisi Icon Profil Pengguna
                    bottom: 10,
                    right: 10,
                    child: Image.asset(
                      'assets/icons/icon_profile.png',
                      width: 40,
                      height: 40,
                    ),
                  ),
                  Positioned(
                    bottom: 2,
                    right: 50,
                    child: IconButton(
                      iconSize: 40,
                      color: const Color(0xffCBE4DE),
                      onPressed: () {
                        showMyDialog(context);
                      },
                      icon: const Icon(Icons.qr_code_2_rounded),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
