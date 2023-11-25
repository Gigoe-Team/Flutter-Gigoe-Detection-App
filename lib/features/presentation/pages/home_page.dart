import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigoe_detection_app/features/presentation/bloc/data_chart_bloc.dart';
import 'package:gigoe_detection_app/features/presentation/pages/user_page.dart';
import 'package:gigoe_detection_app/features/presentation/widgets/custom_chart.dart';
import 'package:gigoe_detection_app/features/presentation/widgets/user_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gigoe_detection_app/core/utils/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loginUser = UserModel();
  late String _userName = '';
  @override
  void initState() {
    super.initState();

    context.read<DataChartBloc>().add(OnGetDataChartEvent());
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
    double screenHeight = MediaQuery.of(context).size.height;
    final List<String> images = [
      'assets/images/slider1.png',
      'assets/images/slider2.png',
      'assets/images/slider3.png',
    ];

    return Scaffold(
      backgroundColor: AppColors.softWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.contain,
              height: 40,
            ),
          ],
        ),
      ),
      body: SizedBox(
        height: screenHeight,
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: () {
                  context.read<DataChartBloc>().add(OnGetDataChartEvent());
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  width: MediaQuery.of(context).size.width / 1.12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: AppColors.primaryBlue,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Halo,',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: AppColors.softWhite,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'drg. $_userName',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.softWhite,
                            ),
                          ),
                        ],
                      ),
                      const ProfileAvatarUser(),
                      // const CircleAvatar(
                      //   backgroundColor: AppColors.softWhite,
                      //   radius: 30,
                      //   child: Icon(
                      //     Icons.person,
                      //     size: 40,
                      //     color: AppColors.primaryBlue,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            CarouselSlider(
              items: images.map((imagePath) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                height: 150,
                initialPage: 0,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                // onPageChanged: (index, reason) {
                //   if (kDebugMode) {
                //     print('Halaman berubah ke: $index');
                //   }
                // },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Peta Sebaran",
                        style: GoogleFonts.poppins(
                            color: AppColors.darkBlue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Visualisasi data prevalensi karies dalam bentuk grafik berdasarkan wilayah dan jumlah total gigi DMF dari semua pasien.",
                        style: GoogleFonts.poppins(
                            color: AppColors.darkBlue,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: BlocBuilder<DataChartBloc, DataChartState>(
                builder: (context, state) {
                  if (state is DataChartHasData) {
                    return CustomChart(result: state.datas);
                  }
                  return const SizedBox();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 90),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   "Keterangan :",
                      //   style: GoogleFonts.poppins(
                      //       color: AppColors.darkBlue,
                      //       fontSize: 18,
                      //       fontWeight: FontWeight.bold),
                      // ),
                      // const SizedBox(height: 10),
                      Text(
                        "BN : Baiturrahman\nKA : Kuta Alam\nMX : Meuraxa\nSK : Syiah Kuala\nLB : Lueng Bata\nKR : Kuta Raja\nBR : Banda Raya\nJB : Jaya Baru\nUK : Ulee Kareng",
                        style: GoogleFonts.poppins(
                            color: AppColors.darkBlue,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                      // Text(
                      //   "X = kode alamat berdasarkan kecamatan\nY = jumlah total gigi DMF dari semua pasien per kecamatan.",
                      //   style: GoogleFonts.poppins(
                      //       fontSize: 13, fontWeight: FontWeight.normal),
                      // ),
                      // Text(
                      //   "Kecamatan di Kota Banda Aceh:",
                      //   style: GoogleFonts.poppins(
                      //       fontSize: 16, fontWeight: FontWeight.w600),
                      // ),
                      // Text(
                      //   "BN : Baiturrahman\nKA : Kuta Alam\nMX : Meuraxa\nSK : Syiah Kuala\nLB : Lueng Bata\nKR : Kuta Raja\nBR : Banda Raya\nJB : Jaya Baru\nUK : Ulee Kareng",
                      //   style: GoogleFonts.poppins(
                      //       fontSize: 14, fontWeight: FontWeight.normal),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileAvatarUser extends StatelessWidget {
  const ProfileAvatarUser({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const UserProfilePage(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        child: const CircleAvatar(
          backgroundColor: AppColors.softWhite,
          radius: 30,
          child: Icon(
            Icons.person,
            size: 40,
            color: AppColors.primaryBlue,
          ),
        ),
      ),
    );
  }
}
