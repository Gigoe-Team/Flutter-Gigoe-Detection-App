// ignore_for_file: avoid_print

import 'package:firebase_database/firebase_database.dart';

abstract class RemoteFirebaseDataSource {
  Future<List<dynamic>> getDataChartFromFirebase();
}

class RemoteFirebaseDataSourceImpl extends RemoteFirebaseDataSource {
  final FirebaseDatabase firebaseDatabase;

  RemoteFirebaseDataSourceImpl(this.firebaseDatabase);

  @override
  Future<List<dynamic>> getDataChartFromFirebase() async {
    try {
      final ref = firebaseDatabase.ref();

      final snapshot = await ref.child('data_pasien').get();

      final data = Map<String, dynamic>.from(snapshot.value as Map);

      List<dynamic> list = data.values.toList();

      return list;
    } catch (e) {
      rethrow;
    }
  }
}
