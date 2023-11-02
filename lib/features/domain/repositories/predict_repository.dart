import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../entities/caries.dart';

abstract class PredictRepository {
  Future<Either<Failure, Caries>> frontImageClassification(String imageFront);
  Future<Either<Failure, Caries>> rightImageClassification(String imageRight);
  Future<Either<Failure, Caries>> leftImageClassification(String imageLeft);
  Future<Either<Failure, Caries>> upperImageClassification(String imageUpper);
  Future<Either<Failure, Caries>> lowerImageClassification(String imageLower);

  Future<Either<Failure, Uint8List>> imgFrontResponse(String imgFront);
  Future<Either<Failure, Uint8List>> imgRightResponse(String imgRight);
  Future<Either<Failure, Uint8List>> imgLeftResponse(String imgLeft);
  Future<Either<Failure, Uint8List>> imgUpperResponse(String imgUpper);
  Future<Either<Failure, Uint8List>> imgLowerResponse(String imgLower);
}
