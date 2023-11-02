part of 'data_chart_bloc.dart';

sealed class DataChartState extends Equatable {
  const DataChartState();

  @override
  List<Object> get props => [];
}

final class DataChartInitial extends DataChartState {}

final class DataChartLoading extends DataChartState {}

final class DataChartError extends DataChartState {
  final String message;

  const DataChartError(this.message);

  @override
  List<Object> get props => [message];
}

final class DataChartHasData extends DataChartState {
  final Map<String, double> datas;

  const DataChartHasData(this.datas);

  @override
  List<Object> get props => [datas];
}
