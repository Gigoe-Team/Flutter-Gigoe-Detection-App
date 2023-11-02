import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../domain/repositories/firebase_repository.dart';
import '../datasources/remote_firebase_data_source.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final RemoteFirebaseDataSource remoteFirebaseDataSource;

  FirebaseRepositoryImpl(this.remoteFirebaseDataSource);

  @override
  Future<Either<Failure, List<dynamic>>> getDataChart() async {
    try {
      final result = await remoteFirebaseDataSource.getDataChartFromFirebase();
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
