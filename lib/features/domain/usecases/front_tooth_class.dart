import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../entities/caries.dart';
import '../repositories/predict_repository.dart';

class CreateFrontImageClassification {
  final PredictRepository repository;

  CreateFrontImageClassification(this.repository);

  Future<Either<Failure, Caries>> execute(String image) {
    return repository.frontImageClassification(image);
  }
}

class FrontImageResponse {
  final PredictRepository repository;

  FrontImageResponse(this.repository);

  Future<Either<Failure, Uint8List>> execute(String image) {
    return repository.imgFrontResponse(image);
  }
}
