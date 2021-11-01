
import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_first_flutter/database/database.dart';

class MyDatabase {
  final databaseName = "My_DB";

  Future<AppDatabase?> getDatabase() {
    return $FloorAppDatabase.databaseBuilder('app_database.db').build();
  }
}