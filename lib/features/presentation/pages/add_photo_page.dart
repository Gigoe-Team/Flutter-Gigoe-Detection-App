import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/app_colors.dart';
import '../bloc/classification_bloc.dart';
import '../bloc/img_response_bloc.dart';
import '../widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'result_detection_page.dart';
import 'dart:io';

class AddPhoto extends StatefulWidget {
  const AddPhoto({
    Key? key,
  }) : super(key: key);

  @override
  State<AddPhoto> createState() => _AddPhotoState();
}

class _AddPhotoState extends State<AddPhoto> {
  late ImagePicker _imagePicker;

  final Map<String, String?> _imageFiles = {
    'Gigi Labial': null,
    'Gigi Bukal Kanan': null,
    'Gigi Bukal Kiri': null,
    'Gigi Oklusal Atas': null,
    'Gigi Oklusal Bawah': null,
  };

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
  }

  Future<void> _uploadImageFromGallery(String title) async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _imageFiles[title] = pickedImage.path;
      }
    });
  }

  Future<void> _takeImageFromCamera(String title) async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedImage != null) {
        _imageFiles[title] = pickedImage.path;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final String name = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      backgroundColor: AppColors.softWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        elevation: 0,
        toolbarHeight: 80,
        title: Text(
          "Tambah Foto",
          style: GoogleFonts.poppins(
              color: AppColors.primaryBlue,
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigator.pop(context);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) => const BottomNavBar(),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: _buildImageCard(
                    'Gigi Labial',
                    'PHOTO 1 OF 5',
                    _imageFiles['Gigi Labial'],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: _buildImageCard(
                    'Gigi Bukal Kanan',
                    'PHOTO 2 OF 5',
                    _imageFiles['Gigi Bukal Kanan'],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: _buildImageCard(
                    'Gigi Bukal Kiri',
                    'PHOTO 3 OF 5',
                    _imageFiles['Gigi Bukal Kiri'],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: _buildImageCard(
                    'Gigi Oklusal Atas',
                    'PHOTO 4 OF 5',
                    _imageFiles['Gigi Oklusal Atas'],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: _buildImageCard(
                    'Gigi Oklusal Bawah',
                    'PHOTO 5 OF 5',
                    _imageFiles['Gigi Oklusal Bawah'],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.softWhite,
                      backgroundColor: AppColors.primaryBlue,
                      minimumSize: const Size(300, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      context.read<ImgResponseBloc>().add(
                            OnCombinedImgResponse(
                              frontImage: _imageFiles['Gigi Labial']!,
                              rightImage: _imageFiles['Gigi Bukal Kanan']!,
                              leftImage: _imageFiles['Gigi Bukal Kiri']!,
                              upperImage: _imageFiles['Gigi Oklusal Atas']!,
                              lowerImage: _imageFiles['Gigi Oklusal Bawah']!,
                            ),
                          );
                      context.read<ClassificationBloc>().add(
                            OnCombinedClassification(
                              frontImage: _imageFiles['Gigi Labial']!,
                              rightImage: _imageFiles['Gigi Bukal Kanan']!,
                              leftImage: _imageFiles['Gigi Bukal Kiri']!,
                              upperImage: _imageFiles['Gigi Oklusal Atas']!,
                              lowerImage: _imageFiles['Gigi Oklusal Bawah']!,
                            ),
                          );
                    },
                    child: BlocConsumer<ImgResponseBloc, ImgResponseState>(
                      listener: (context, state) {
                        if (state is CombinedImgResponseState) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ResultDetectionPage(name: name);
                              },
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is ImgResponseLoading) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: CircularProgressIndicator(
                                  color: AppColors.softWhite),
                            ),
                          );
                        }
                        return Center(
                          child: Text(
                            "Proses",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageCard(
    String title,
    String subtitle,
    String? imageFile,
  ) {
    return Container(
      height: 305,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              Text(
                subtitle,
                style: GoogleFonts.poppins(),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: 180,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(12),
            ),
            child: imageFile != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(imageFile),
                      fit: BoxFit.cover,
                    ),
                  )
                : const Icon(Icons.image_not_supported_rounded, size: 30),
          ),
          const SizedBox(height: 10),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    _uploadImageFromGallery(title);
                  },
                  icon: const Icon(
                    Icons.upload_rounded,
                    size: 20,
                  ),
                  label: Text(
                    "Upload",
                    style: GoogleFonts.poppins(),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    foregroundColor: AppColors.softWhite,
                    backgroundColor: AppColors.primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    _takeImageFromCamera(title);
                  },
                  icon: const Icon(
                    Icons.photo_camera_rounded,
                    size: 20,
                  ),
                  label: Text(
                    "Camera",
                    style: GoogleFonts.poppins(),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    foregroundColor: Colors.white,
                    backgroundColor: AppColors.darkBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
