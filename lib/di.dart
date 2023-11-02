import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';

import 'features/data/datasources/remote_data_source.dart';
import 'features/data/datasources/remote_firebase_data_source.dart';
import 'features/data/repositories/firebase_repository_impl.dart';
import 'features/data/repositories/predict_repository_impl.dart';
import 'features/domain/repositories/firebase_repository.dart';
import 'features/domain/repositories/predict_repository.dart';
import 'features/domain/usecases/front_tooth_class.dart';
import 'features/domain/usecases/get_data_chart.dart';
import 'features/domain/usecases/left_tooth_class.dart';
import 'features/domain/usecases/lower_tooth_class.dart';
import 'features/domain/usecases/right_tooth_class.dart';
import 'features/domain/usecases/upper_tooth_class.dart';
import 'features/presentation/bloc/classification_bloc.dart';
import 'features/presentation/bloc/data_chart_bloc.dart';
import 'features/presentation/bloc/img_response_bloc.dart';

GetIt locator = GetIt.I;

Future<void> setup() async {
  // BLOC STATE INJECTION
  locator.registerFactory(() => ClassificationBloc(
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
      ));

  locator.registerFactory(() => ImgResponseBloc(
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
      ));

  locator.registerFactory(() => DataChartBloc(
        locator(),
      ));

  // USE CASE
  // Front
  locator
      .registerLazySingleton(() => CreateFrontImageClassification(locator()));
  locator.registerLazySingleton(() => FrontImageResponse(locator()));

  // Right
  locator
      .registerLazySingleton(() => CreateRightImageClassification(locator()));
  locator.registerLazySingleton(() => RightImageResponse(locator()));

  // Left
  locator.registerLazySingleton(() => CreateLeftImageClassification(locator()));
  locator.registerLazySingleton(() => LeftImageResponse(locator()));

  // Upper
  locator
      .registerLazySingleton(() => CreateUpperImageClassification(locator()));
  locator.registerLazySingleton(() => UpperImageResponse(locator()));

  // Lower
  locator
      .registerLazySingleton(() => CreateLowerImageClassification(locator()));
  locator.registerLazySingleton(() => LowerImageResponse(locator()));

  // Data Chart
  locator.registerLazySingleton(() => GetDataChartFromFirebase(locator()));

  // REPOSITORY INJECTION
  locator.registerLazySingleton<PredictRepository>(
    () => PredictRepositoryImpl(dataSource: locator()),
  );

  locator.registerLazySingleton<FirebaseRepository>(
    () => FirebaseRepositoryImpl(locator()),
  );

  // DATA SOURCE INJECTION
  locator.registerLazySingleton<PredictRemoteDataSource>(
    () => PredictRemoteDataSourceImpl(locator()),
  );

  locator.registerLazySingleton<RemoteFirebaseDataSource>(
    () => RemoteFirebaseDataSourceImpl(locator()),
  );

  // EXTERNAL
  locator.registerLazySingleton(() => Dio());
  locator.registerLazySingleton(() => FirebaseDatabase.instance);
}
