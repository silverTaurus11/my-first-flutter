// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  AppDao? _appDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `product_entity` (`id` INTEGER NOT NULL, `image_url` TEXT NOT NULL, `title` TEXT NOT NULL, `description` TEXT NOT NULL, `price` TEXT NOT NULL, `loved` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `purchase_entity` (`purchase_id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `product_id` INTEGER NOT NULL, `qty` INTEGER NOT NULL, `transaction_date` INTEGER NOT NULL, FOREIGN KEY (`product_id`) REFERENCES `product_entity` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  AppDao get appDao {
    return _appDaoInstance ??= _$AppDao(database, changeListener);
  }
}

class _$AppDao extends AppDao {
  _$AppDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _productEntityInsertionAdapter = InsertionAdapter(
            database,
            'product_entity',
            (ProductEntity item) => <String, Object?>{
                  'id': item.id,
                  'image_url': item.imageUrl,
                  'title': item.title,
                  'description': item.description,
                  'price': item.price,
                  'loved': item.loved
                },
            changeListener),
        _purchaseEntityInsertionAdapter = InsertionAdapter(
            database,
            'purchase_entity',
            (PurchaseEntity item) => <String, Object?>{
                  'purchase_id': item.id,
                  'product_id': item.productId,
                  'qty': item.qty,
                  'transaction_date': item.dateInMillis
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ProductEntity> _productEntityInsertionAdapter;

  final InsertionAdapter<PurchaseEntity> _purchaseEntityInsertionAdapter;

  @override
  Future<List<ProductEntity>> getProducts() async {
    return _queryAdapter.queryList(
        'SELECT * FROM product_entity ORDER BY id ASC',
        mapper: (Map<String, Object?> row) => ProductEntity(
            row['id'] as int,
            row['image_url'] as String,
            row['title'] as String,
            row['description'] as String,
            row['price'] as String,
            row['loved'] as int));
  }

  @override
  Stream<ProductEntity?> getProduct(int id) {
    return _queryAdapter.queryStream(
        'SELECT * FROM product_entity WHERE id= ?1',
        mapper: (Map<String, Object?> row) => ProductEntity(
            row['id'] as int,
            row['image_url'] as String,
            row['title'] as String,
            row['description'] as String,
            row['price'] as String,
            row['loved'] as int),
        arguments: [id],
        queryableName: 'product_entity',
        isView: false);
  }

  @override
  Future<int?> checkProduct(int id) async {
    await _queryAdapter.queryNoReturn(
        'SELECT COUNT(id) FROM product_entity WHERE id =?1',
        arguments: [id]);
  }

  @override
  Future<void> updateProduct(int id, String imageUrl, String title,
      String description, String price) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE product_entity SET imageUrl = ?2, title = ?3, description = ?4, price = ?5 WHERE id = ?1',
        arguments: [id, imageUrl, title, description, price]);
  }

  @override
  Future<void> deleteProduct() async {
    await _queryAdapter.queryNoReturn('DELETE FROM product_entity');
  }

  @override
  Future<List<ProductEntity>> getLikedProducts() async {
    return _queryAdapter.queryList(
        'SELECT * FROM product_entity WHERE loved = 1',
        mapper: (Map<String, Object?> row) => ProductEntity(
            row['id'] as int,
            row['image_url'] as String,
            row['title'] as String,
            row['description'] as String,
            row['price'] as String,
            row['loved'] as int));
  }

  @override
  Future<void> updateLikedProduct(bool loved, int id) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE product_entity SET loved = ?1 WHERE id = ?2',
        arguments: [loved ? 1 : 0, id]);
  }

  @override
  Future<List<ProductEntity>> searchProduct(String query) async {
    return _queryAdapter.queryList(
        'SELECT * FROM product_entity WHERE title LIKE ?1',
        mapper: (Map<String, Object?> row) => ProductEntity(
            row['id'] as int,
            row['image_url'] as String,
            row['title'] as String,
            row['description'] as String,
            row['price'] as String,
            row['loved'] as int),
        arguments: [query]);
  }

  @override
  Future<List<PurchaseEntity>> getPurchaseHistory() async {
    return _queryAdapter.queryList(
        'SELECT * FROM purchase_entity ORDER BY transaction_date DESC',
        mapper: (Map<String, Object?> row) => PurchaseEntity(
            row['purchase_id'] as int,
            row['product_id'] as int,
            row['qty'] as int,
            row['transaction_date'] as int));
  }

  @override
  Future<void> deletePurchaseHistory() async {
    await _queryAdapter.queryNoReturn('DELETE FROM purchase_entity');
  }

  @override
  Future<void> insertProduct(ProductEntity item) async {
    await _productEntityInsertionAdapter.insert(
        item, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertProducts(List<ProductEntity> item) async {
    await _productEntityInsertionAdapter.insertList(
        item, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertPurchaseHistory(PurchaseEntity item) async {
    await _purchaseEntityInsertionAdapter.insert(
        item, OnConflictStrategy.replace);
  }
}
