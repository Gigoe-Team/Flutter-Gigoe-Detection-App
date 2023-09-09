import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:gigoe_detection_app/features/presentation/pages/add_photo_page.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPatient extends StatefulWidget {
  const AddPatient({Key? key}) : super(key: key);

  @override
  State<AddPatient> createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _lahirController = TextEditingController();
  final TextEditingController _pekerjaanController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nomorController = TextEditingController();

  String _selectedGender = 'Laki-laki';
  String _selectedDistrict = 'Baiturrahman';
  String _selectedProfession = 'Belum/Tidak Bekerja';

  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('data_pasien');
  }

  get firestore => null;

  void _tambahpasien() {
    Map<String, String> datapasien = {
      'nik': _nikController.text.trim(),
      'nama': _namaController.text.trim(),
      'ttl': _lahirController.text.trim(),
      'alamat': _selectedDistrict,
      'gender': _selectedGender,
      'pekerjaan': _selectedProfession,
      'email': _emailController.text.trim(),
      'nomor': _nomorController.text.trim(),
    };
    if (_namaController.text != "" || _namaController.text != null) {
      dbRef.child('${_namaController.text.trim()}').set(datapasien);
    } else {
      print("no data");
    }
  }

  @override
  void dispose() {
    _nikController.dispose();
    _namaController.dispose();
    _lahirController.dispose();
    _pekerjaanController.dispose();
    _emailController.dispose();
    _nomorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffCBE4DE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 80,
        title: Text(
          "Tambah  Pasien",
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildNikField("NIK", _nikController),
              _buildInputField(
                  "Nama Pasien", TextInputType.text, _namaController),
              _buildDateField("Tanggal Lahir", _lahirController),
              _buildDistrictDropdown("Alamat (Kecamatan)"),
              _buildGenderDropdown("Jenis Kelamin"),
              _buildProfessionDropdown("Pekerjaan"),
              _buildInputField(
                  "Email", TextInputType.emailAddress, _emailController),
              _buildInputField(
                  "Nomor Handphone", TextInputType.number, _nomorController),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCancelButton(
                      // Tombol Batal menghapus seluruh data yang telah diisi
                      "Batal",
                      const Color(0xffD90000),
                      130,
                      50, () {
                    _resetControllers();
                  }),
                  MaterialButton(
                    onPressed: () {
                      _tambahpasien();
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/add_photo', (route) => false);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: const Color(0xff2E4F4F),
                    textColor: Colors.white,
                    minWidth: 130,
                    height: 50,
                    child: Text(
                      'Lanjutkan',
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String hintText, TextInputType inputType,
      TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hintText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: 50,
            child: TextFormField(
              controller: controller,
              keyboardType: inputType,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 2, color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    width: 2,
                    color: Color(0xff0E8388),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNikField(String hintText, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hintText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: 50,
            child: Column(
              children: [
                TextFormField(
                  controller: _nikController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 2,
                        color: Colors.black,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 2,
                        color: Color(0xff0E8388),
                      ),
                    ),
                  ),
                  // Fungsi validasi NIK
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'NIK tidak boleh kosong';
                    }
                    if (value.length != 16) {
                      return 'NIK harus terdiri dari 16 karakter';
                    }
                    return null;
                  },
                  onSaved: (val) {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateField(String hintText, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hintText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
          DateTimePicker(
            type: DateTimePickerType.date,
            controller: _lahirController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  width: 2,
                  color: Colors.black,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  width: 2,
                  color: Color(0xff0E8388),
                ),
              ),
              suffixIcon: const Icon(
                Icons.calendar_today,
                color: Color(0xff0E8388),
              ),
            ),
            dateMask: 'dd/MM/yyyy',
            // initialValue: '',
            firstDate: DateTime(1900),
            lastDate: DateTime(2101),
            onChanged: (val) {},
            validator: (val) {
              if (val!.isEmpty) {
                return 'Tanggal tidak boleh kosong';
              }
              return null;
            },
            onSaved: (val) {},
          ),
        ],
      ),
    );
  }

  Widget _buildDistrictDropdown(String hintText) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hintText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: 50,
            child: DropdownButtonFormField<String>(
              value: _selectedDistrict,
              items: <String>[
                'Baiturrahman',
                'Kuta Alam',
                'Meuraxa',
                'Syiah Kuala',
                'Lueng Bata',
                'Kuta Raja',
                'Banda Raya',
                'Jaya Baru',
                'Ulee Kareng',
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedDistrict = newValue!;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    width: 2,
                    color: Colors.black,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    width: 2,
                    color: Color(0xff0E8388),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderDropdown(String hintText) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hintText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: 50,
            child: DropdownButtonFormField<String>(
              value: _selectedGender,
              items: <String>['Laki-laki', 'Perempuan'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedGender = newValue!;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    width: 2,
                    color: Colors.black,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    width: 2,
                    color: Color(0xff0E8388),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfessionDropdown(String hintText) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hintText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: 50,
            child: DropdownButtonFormField<String>(
              value: _selectedProfession,
              items: <String>[
                'Belum/Tidak Bekerja',
                'Mengurus Rumah Tangga',
                'Pelajar/Mahasiswa',
                'Pegawai Negeri Sipil',
                'Wiraswasta',
                'Petani/Pekebun',
                'Pensiunan',
                'Buruh',
                'Tukang',
                'Lainnya',
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedProfession = newValue!;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    width: 2,
                    color: Colors.black,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    width: 2,
                    color: Color(0xff0E8388),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Tombol Batal
  Widget _buildCancelButton(
    String text,
    Color color,
    double width,
    double height,
    Function()? onPressed,
  ) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 14,
          ),
        ),
      ),
    );
  }

// Reset data di dalam field
  void _resetControllers() {
    _nikController.clear();
    _namaController.clear();
    _lahirController.clear();
    _emailController.clear();
    _nomorController.clear();
  }
}
