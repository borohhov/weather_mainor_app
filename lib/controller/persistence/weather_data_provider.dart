import 'package:flutter/material.dart';
import 'package:weather_mainor_app/controller/persistence/firestore.dart';
import 'package:weather_mainor_app/controller/persistence/persistence.dart';
import 'package:weather_mainor_app/controller/persistence/sqlite.dart';
import 'package:weather_mainor_app/controller/utils.dart';
import 'package:weather_mainor_app/models/weather_data.dart';
import 'package:weather_mainor_app/models/weather_data_log.dart';

class WeatherDataProvider extends ChangeNotifier {
  Persistence db = FirestoreController();

  Future<List<WeatherDataLog>> get data async {
    await db.init();
    return db.getAllData();
  }

  Future<void> updateData(WeatherDataLog newData) async{
    await db.init();
    db.saveData(newData);
    notifyListeners();
  }
}
