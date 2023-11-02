import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../repositories/firebase_repository.dart';

class GetDataChartFromFirebase {
  final FirebaseRepository repository;

  GetDataChartFromFirebase(this.repository);

  Future<Either<Failure, List<dynamic>>> execute() {
    return repository.getDataChart();
  }
}
