part of 'data_chart_bloc.dart';

sealed class DataChartEvent extends Equatable {
  const DataChartEvent();

  @override
  List<Object> get props => [];
}

final class OnGetDataChartEvent extends DataChartEvent {}
