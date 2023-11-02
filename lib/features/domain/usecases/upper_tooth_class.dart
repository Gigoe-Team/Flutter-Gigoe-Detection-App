import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../entities/caries.dart';
import '../repositories/predict_repository.dart';

class CreateUpperImageClassification {
  final PredictRepository repository;

  CreateUpperImageClassification(this.repository);

  Future<Either<Failure, Caries>> execute(String image) {
    return repository.upperImageClassification(image);
  }
}

class UpperImageResponse {
  final PredictRepository repository;

  UpperImageResponse(this.repository);

  Future<Either<Failure, Uint8List>> execute(String image) {
    return repository.imgRightResponse(image);
  }
}
