import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../entities/caries.dart';
import '../repositories/predict_repository.dart';

class CreateRightImageClassification {
  final PredictRepository repository;

  CreateRightImageClassification(this.repository);

  Future<Either<Failure, Caries>> execute(String image) {
    return repository.rightImageClassification(image);
  }
}

class RightImageResponse {
  final PredictRepository repository;

  RightImageResponse(this.repository);

  Future<Either<Failure, Uint8List>> execute(String image) {
    return repository.imgRightResponse(image);
  }
}
