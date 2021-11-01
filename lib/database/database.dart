
import 'package:floor/floor.dart';
import 'package:my_first_flutter/model/database/product_entity.dart';
import 'package:my_first_flutter/model/database/purchase_entity.dart';

// required package imports
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:my_first_flutter/database/my_dao.dart';

part 'database.g.dart';

@Database(version: 1, entities: [ProductEntity, PurchaseEntity])
abstract class AppDatabase extends FloorDatabase {
  AppDao get appDao;
}