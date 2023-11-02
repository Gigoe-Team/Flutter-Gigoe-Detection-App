import '../../domain/entities/data_chart.dart';

class PatientModel extends DataChart {
  const PatientModel({
    String? alamat,
    int? totalHilang,
    int? totalKaries,
    int? totalTambal,
  }) : super(
          alamat: alamat,
          totalHilang: totalHilang,
          totalKaries: totalKaries,
          totalTambal: totalTambal,
        );

  factory PatientModel.fromMap(Map<String, dynamic> map) => PatientModel(
        alamat: map['alamat'] ?? '',
        totalHilang: map['total_hilang'] ?? 0,
        totalKaries: map['total_karies'] ?? 0,
        totalTambal: map['total_tambal'] ?? 0,
      );

  PatientModel toEntity() => PatientModel(
        alamat: alamat,
        totalHilang: totalHilang,
        totalKaries: totalKaries,
        totalTambal: totalTambal,
      );

  @override
  List<Object?> get props => [alamat, totalHilang, totalKaries, totalTambal];
}
