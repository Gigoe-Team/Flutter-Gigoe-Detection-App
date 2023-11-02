import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecases/get_data_chart.dart';

part 'data_chart_event.dart';
part 'data_chart_state.dart';

class DataChartBloc extends Bloc<DataChartEvent, DataChartState> {
  final GetDataChartFromFirebase _getDataChartFromFirebase;

  DataChartBloc(this._getDataChartFromFirebase) : super(DataChartInitial()) {
    on<OnGetDataChartEvent>((event, emit) async {
      emit(DataChartLoading());

      final result = await _getDataChartFromFirebase.execute();

      final test = await getHasil(result);

      result.fold(
        (failure) => emit(DataChartError(failure.message)),
        (_) => emit(DataChartHasData(test)),
      );
    });
  }
}

Future<int> getTotalKerusakan(data) async {
  return data['total_hilang'] + data['total_karies'] + data['total_tambal'];
}

Future<List<Map<String, dynamic>>> filterDataByAlamat(data, alamat) async {
  return data.where((item) => item.alamat == alamat).toList();
}

Future<Map<String, double>> getHasil(data) async {
  const alamat = [
    'Baiturrahman',
    'Kuta Alam',
    'Meuraxa',
    'Syiah Kuala',
    'Lueng Bata',
    'Kuta Raja',
    'Banda Raya',
    'Jaya Baru',
    'Ulee Kareng'
  ];

  Map<String, double> hasil = {};

  for (var i = 0; i < alamat.length; i++) {
    final dataAlamat = data.getOrElse(() => []);

    final filteredDataAlamat =
        dataAlamat.where((item) => item['alamat'] == alamat[i]).toList();

    double totalKerusakan = 0;
    for (var j = 0; j < filteredDataAlamat.length; j++) {
      if (filteredDataAlamat[j]['total_hilang'] != null &&
          filteredDataAlamat[j]['total_karies'] != null &&
          filteredDataAlamat[j]['total_tambal'] != null) {
        totalKerusakan += await getTotalKerusakan(filteredDataAlamat[j]);
      }
    }

    hasil[alamat[i]] = totalKerusakan;
  }

  return hasil;
}
