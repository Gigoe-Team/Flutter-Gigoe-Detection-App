import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';

abstract class FirebaseRepository {
  Future<Either<Failure, List<dynamic>>> getDataChart();
}
