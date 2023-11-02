import 'package:equatable/equatable.dart';

class DataChart extends Equatable {
  final String? alamat;
  final int? totalHilang;
  final int? totalKaries;
  final int? totalTambal;

  const DataChart({
    this.alamat,
    this.totalHilang,
    this.totalKaries,
    this.totalTambal,
  });

  @override
  List<Object?> get props => [alamat, totalHilang, totalKaries, totalTambal];
}
