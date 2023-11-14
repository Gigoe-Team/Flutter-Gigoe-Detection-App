import 'package:dartz/dartz.dart';

import 'package:gigoe_detection_app/core/error/failures.dart';
import 'package:gigoe_detection_app/features/domain/repositories/firebase_repository.dart';

class GetDataChartFromFirebase {
  final FirebaseRepository repository;

  GetDataChartFromFirebase(this.repository);

  Future<Either<Failure, List<dynamic>>> execute() {
    return repository.getDataChart();
  }
}
