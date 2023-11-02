import 'package:equatable/equatable.dart';

import '../../domain/entities/caries.dart';
import 'prediction_model.dart';

class CariesModel extends Equatable {
  final double? time;
  final List<PredictionModel> predictions;

  const CariesModel({this.time, required this.predictions});

  factory CariesModel.fromJson(Map<String, dynamic> json) => CariesModel(
        time: (json['time'] as num?)?.toDouble(),
        predictions: (json['predictions'] as List<dynamic>)
            .map((e) => PredictionModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'time': time,
        'predictions': predictions.map((e) => e.toJson()).toList(),
      };

  Caries toEntity() => Caries(
        time: time,
        predictions: predictions.map((e) => e.toEntity()).toList(),
      );

  @override
  List<Object?> get props => [time, predictions];
}
