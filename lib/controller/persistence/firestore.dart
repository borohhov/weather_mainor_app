import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weather_mainor_app/controller/persistence/persistence.dart';
import 'package:weather_mainor_app/models/weather_data_log.dart';

class FirestoreController implements Persistence {
  final collection = 'weather_logs';
  late FirebaseFirestore _db;

  @override
  Future<List<WeatherDataLog>> getAllData() async {
    List<WeatherDataLog> logs = [];
    QuerySnapshot querySnapshot = await _db.collection(collection).get();
    for (var docSnapshot in querySnapshot.docs) {
      logs.add(WeatherDataLog.fromJson(docSnapshot.data() as Map));
    }
    return logs;
  }

  @override
  Future<void> init() async {
    _db = FirebaseFirestore.instance;
  }

  @override
  Future<void> saveData(WeatherDataLog data) async {
    _db.collection(collection).doc().set(data.toJson());
  }
}