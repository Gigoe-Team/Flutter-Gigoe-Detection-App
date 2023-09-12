import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:gigoe_detection_app/features/presentation/bloc/img_response_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gigoe_detection_app/features/domain/entities/prediction.dart';
import 'package:gigoe_detection_app/features/presentation/bloc/classification_bloc.dart';

import '../widgets/bottom_nav_bar.dart';

class ResultDetectionPage extends StatefulWidget {
  const ResultDetectionPage({super.key, required this.name});

  final String name;

  @override
  State<ResultDetectionPage> createState() => _ResultDetectionPageState();
}

class _ResultDetectionPageState extends State<ResultDetectionPage> {
  // Front
  List<String> frontCaries = [];
  List<String> frontMissing = [];
  List<String> frontFilling = [];

  // Right
  List<String> rightCaries = [];
  List<String> rightMissing = [];
  List<String> rightFilling = [];

  // Left
  List<String> leftCaries = [];
  List<String> leftMissing = [];
  List<String> leftFilling = [];

  // Upper
  List<String> upperCaries = [];
  List<String> upperMissing = [];
  List<String> upperFilling = [];

  // Lower
  List<String> lowerCaries = [];
  List<String> lowerMissing = [];
  List<String> lowerFilling = [];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    List<String> filterData(
      List<Prediction> predictions,
      String predictionClass,
    ) {
      return predictions
          .where((element) => element.predictionClass == predictionClass)
          .map((e) => e.predictionClass)
          .toList()
          .cast<String>();
    }

    context.select<ClassificationBloc, void>((value) {
      final state = value.state;

      if (state is CombinedClassificationState) {
        setState(() {
          // Front
          frontCaries = filterData(state.frontData.predictions!, "Karies");
          frontMissing = filterData(state.frontData.predictions!, "Hilang");
          frontFilling = filterData(state.frontData.predictions!, "Tambal");

          // Right
          rightCaries = filterData(state.rightData.predictions!, "Karies");
          rightMissing = filterData(state.rightData.predictions!, "Hilang");
          rightFilling = filterData(state.rightData.predictions!, "Tambal");

          // Left
          leftCaries = filterData(state.leftData.predictions!, "Karies");
          leftMissing = filterData(state.leftData.predictions!, "Hilang");
          leftFilling = filterData(state.leftData.predictions!, "Tambal");

          // Upper
          upperCaries = filterData(state.upperData.predictions!, "Karies");
          upperMissing = filterData(state.upperData.predictions!, "Hilang");
          upperFilling = filterData(state.upperData.predictions!, "Tambal");

          // Lower
          lowerCaries = filterData(state.lowerData.predictions!, "Karies");
          lowerMissing = filterData(state.lowerData.predictions!, "Hilang");
          lowerFilling = filterData(state.lowerData.predictions!, "Tambal");
        });
      }
    });

    int totalCaries = frontCaries.length +
        rightCaries.length +
        leftCaries.length +
        upperCaries.length +
        lowerCaries.length;

    int totalMissing = frontMissing.length +
        rightMissing.length +
        leftMissing.length +
        upperMissing.length +
        lowerMissing.length;

    int totalFilling = frontFilling.length +
        rightFilling.length +
        leftFilling.length +
        upperFilling.length +
        lowerFilling.length;

    return Scaffold(
      backgroundColor: const Color(0xffCBE4DE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 80,
        title: Text(
          "Hasil Deteksi",
          style: GoogleFonts.poppins(
              color: const Color(0xffffffff),
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
        leading: const SizedBox(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: CarouselSlider(
              items: [
                BlocBuilder<ImgResponseBloc, ImgResponseState>(
                  builder: (context, state) {
                    if (state is CombinedImgResponseState) {
                      return ResultDetectionCard(
                        imageBytes: state.frontImgUint8List,
                        caries: frontCaries.length,
                        filledTooth: frontMissing.length,
                        missingTooth: frontFilling.length,
                        title: "Gigi Depan",
                        subtitle: "PHOTO 1 OF 5",
                      );
                    }
                    return const ResultDetectionLoading();
                  },
                ),
                BlocBuilder<ImgResponseBloc, ImgResponseState>(
                  builder: (context, state) {
                    if (state is CombinedImgResponseState) {
                      return ResultDetectionCard(
                        imageBytes: state.rightImgUint8List,
                        caries: rightCaries.length,
                        filledTooth: rightMissing.length,
                        missingTooth: rightFilling.length,
                        title: "Gigi Kanan",
                        subtitle: "PHOTO 2 OF 5",
                      );
                    }
                    return const ResultDetectionLoading();
                  },
                ),
                BlocBuilder<ImgResponseBloc, ImgResponseState>(
                  builder: (context, state) {
                    if (state is CombinedImgResponseState) {
                      return ResultDetectionCard(
                        imageBytes: state.leftImgUint8List,
                        caries: leftCaries.length,
                        filledTooth: leftMissing.length,
                        missingTooth: leftFilling.length,
                        title: "Gigi Kiri",
                        subtitle: "PHOTO 3 OF 5",
                      );
                    }
                    return const ResultDetectionLoading();
                  },
                ),
                BlocBuilder<ImgResponseBloc, ImgResponseState>(
                  builder: (context, state) {
                    if (state is CombinedImgResponseState) {
                      return ResultDetectionCard(
                        imageBytes: state.upperImgUint8List,
                        caries: upperCaries.length,
                        filledTooth: upperMissing.length,
                        missingTooth: upperFilling.length,
                        title: "Gigi Atas",
                        subtitle: "PHOTO 4 OF 5",
                      );
                    }
                    return const ResultDetectionLoading();
                  },
                ),
                BlocBuilder<ImgResponseBloc, ImgResponseState>(
                  builder: (context, state) {
                    if (state is CombinedImgResponseState) {
                      return ResultDetectionCard(
                        imageBytes: state.lowerImgUint8List,
                        caries: lowerCaries.length,
                        filledTooth: lowerMissing.length,
                        missingTooth: lowerFilling.length,
                        title: "Gigi Bawah",
                        subtitle: "PHOTO 5 OF 5",
                      );
                    }
                    return const ResultDetectionLoading();
                  },
                ),
              ],
              options: CarouselOptions(
                height: height * 0.44,
                disableCenter: true,
                initialPage: 0,
                autoPlay: false,
                autoPlayInterval: const Duration(seconds: 5),
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 38),
            child: ResultoverallConditionCard(
              totalCaries: totalCaries,
              totalMissing: totalMissing,
              totalFilling: totalFilling,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 38, right: 38),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                foregroundColor: const Color(0xffffffff),
                backgroundColor: const Color(0xff0E8388),
                minimumSize: const Size(0, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                await updateData(
                  totalCaries: totalCaries,
                  totalMissing: totalMissing,
                  totalFilling: totalFilling,
                );
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const BottomNavBar(),
                  ),
                );
              },
              child: Center(
                child: Text(
                  "Kembali & Simpan",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  updateData({
    required totalCaries,
    required totalMissing,
    required totalFilling,
  }) {
    var pathName = widget.name.removeAllWhitespace;

    DatabaseReference ref = FirebaseDatabase.instance.ref();
    ref.child('data_pasien').child(pathName).update({
      'total_karies': totalCaries,
      'total_hilang': totalMissing,
      'total_tambal': totalFilling
    });
  }
}

class ResultDetectionCard extends StatelessWidget {
  const ResultDetectionCard({
    super.key,
    this.caries = 0,
    this.missingTooth = 0,
    this.filledTooth = 0,
    required this.imageBytes,
    required this.title,
    required this.subtitle,
  });

  final int caries;
  final int missingTooth;
  final int filledTooth;
  final Uint8List? imageBytes;

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.5,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                subtitle,
                style: GoogleFonts.poppins(),
              )
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: height * 0.20,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(10),
            ),
            child: imageBytes != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.memory(
                      imageBytes!,
                      fit: BoxFit.cover,
                    ),
                  )
                : const SizedBox(),
          ),
          const SizedBox(height: 10),
          Text(
            "Kondisi Gigi",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Gigi Karies ",
                    style: GoogleFonts.poppins(),
                  ),
                  Text(
                    "Gigi Hilang ",
                    style: GoogleFonts.poppins(),
                  ),
                  Text(
                    "Gigi Tambal ",
                    style: GoogleFonts.poppins(),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    ":  ",
                    style: GoogleFonts.poppins(),
                  ),
                  Text(
                    ":  ",
                    style: GoogleFonts.poppins(),
                  ),
                  Text(
                    ":  ",
                    style: GoogleFonts.poppins(),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    caries.toStringAsFixed(0),
                    style: GoogleFonts.poppins(),
                  ),
                  Text(
                    missingTooth.toStringAsFixed(0),
                    style: GoogleFonts.poppins(),
                  ),
                  Text(
                    filledTooth.toStringAsFixed(0),
                    style: GoogleFonts.poppins(),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ResultoverallConditionCard extends StatelessWidget {
  const ResultoverallConditionCard({
    super.key,
    this.totalCaries,
    this.totalMissing,
    this.totalFilling,
  });

  final int? totalCaries;
  final int? totalMissing;
  final int? totalFilling;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Kondisi keselurahan Gigi Pasien",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Gigi Karies ",
                    style: GoogleFonts.poppins(),
                  ),
                  Text(
                    "Total Gigi Hilang ",
                    style: GoogleFonts.poppins(),
                  ),
                  Text(
                    "Total Gigi Tambal ",
                    style: GoogleFonts.poppins(),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    ":  ",
                    style: GoogleFonts.poppins(),
                  ),
                  Text(
                    ":  ",
                    style: GoogleFonts.poppins(),
                  ),
                  Text(
                    ":  ",
                    style: GoogleFonts.poppins(),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    totalCaries.toString(),
                    style: GoogleFonts.poppins(),
                  ),
                  Text(
                    totalMissing.toString(),
                    style: GoogleFonts.poppins(),
                  ),
                  Text(
                    totalFilling.toString(),
                    style: GoogleFonts.poppins(),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ResultDetectionLoading extends StatelessWidget {
  const ResultDetectionLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Gigi Depan",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                "PHOTO 0 OF 0",
                style: GoogleFonts.poppins(),
              )
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: height * 0.22,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.black45,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Gigi Karies ",
                    style: GoogleFonts.poppins(),
                  ),
                  Text(
                    "Gigi Hilang ",
                    style: GoogleFonts.poppins(),
                  ),
                  Text(
                    "Gigi Tambal ",
                    style: GoogleFonts.poppins(),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    ":  ",
                    style: GoogleFonts.poppins(),
                  ),
                  Text(
                    ":  ",
                    style: GoogleFonts.poppins(),
                  ),
                  Text(
                    ":  ",
                    style: GoogleFonts.poppins(),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "0",
                    style: GoogleFonts.poppins(),
                  ),
                  Text(
                    "0",
                    style: GoogleFonts.poppins(),
                  ),
                  Text(
                    "0",
                    style: GoogleFonts.poppins(),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
