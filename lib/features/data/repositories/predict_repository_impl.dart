import 'dart:io';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../domain/entities/caries.dart';
import '../../domain/repositories/predict_repository.dart';
import '../datasources/remote_data_source.dart';

class PredictRepositoryImpl implements PredictRepository {
  final PredictRemoteDataSource dataSource;

  PredictRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, Caries>> frontImageClassification(
    String imageFront,
  ) {
    return _imageClassification(
      () => dataSource.frontImageClassification(imageFront),
    );
  }

  @override
  Future<Either<Failure, Caries>> leftImageClassification(String imageLeft) {
    return _imageClassification(
      () => dataSource.leftImageClassification(imageLeft),
    );
  }

  @override
  Future<Either<Failure, Caries>> rightImageClassification(String imageRight) {
    return _imageClassification(
      () => dataSource.rightImageClassification(imageRight),
    );
  }

  @override
  Future<Either<Failure, Caries>> upperImageClassification(String imageUpper) {
    return _imageClassification(
      () => dataSource.upperImageClassification(imageUpper),
    );
  }

  @override
  Future<Either<Failure, Caries>> lowerImageClassification(String imageLower) {
    return _imageClassification(
      () => dataSource.lowerImageClassification(imageLower),
    );
  }

  Future<Either<Failure, Caries>> _imageClassification(
    Future Function() classificationFunction,
  ) async {
    try {
      final result = await classificationFunction();
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, Uint8List>> imgFrontResponse(String imgFront) {
    return _imageResponse(() => dataSource.imageFrontResponse(imgFront));
  }

  @override
  Future<Either<Failure, Uint8List>> imgLeftResponse(String imgLeft) {
    return _imageResponse(() => dataSource.imageLeftResponse(imgLeft));
  }

  @override
  Future<Either<Failure, Uint8List>> imgLowerResponse(String imgLower) {
    return _imageResponse(() => dataSource.imageLowerResponse(imgLower));
  }

  @override
  Future<Either<Failure, Uint8List>> imgRightResponse(String imgRight) {
    return _imageResponse(() => dataSource.imageRightResponse(imgRight));
  }

  @override
  Future<Either<Failure, Uint8List>> imgUpperResponse(String imgUpper) {
    return _imageResponse(() => dataSource.imageUpperResponse(imgUpper));
  }

  Future<Either<Failure, Uint8List>> _imageResponse(
    Future Function() classificationFunction,
  ) async {
    try {
      final result = await classificationFunction();
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
