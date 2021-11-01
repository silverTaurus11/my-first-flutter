

import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_first_flutter/model/database/product_entity.dart';
import 'package:my_first_flutter/model/database/purchase_entity.dart';

@dao
abstract class AppDao {
  @Query("SELECT * FROM product_entity ORDER BY id ASC")
  Future<List<ProductEntity>> getProducts();

  @Query("SELECT * FROM product_entity WHERE id= :id")
  Stream<ProductEntity?> getProduct(int id);

  @Query("SELECT COUNT(id) FROM product_entity WHERE id =:id")
  Future<int?> checkProduct(int id);

  @Insert(onConflict : OnConflictStrategy.replace)
  Future<void> insertProduct(ProductEntity item);

  @Insert(onConflict : OnConflictStrategy.replace)
  Future<void> insertProducts(List<ProductEntity> item);

  @Query("UPDATE product_entity SET imageUrl = :imageUrl, title = :title, description = :description, price = :price WHERE id = :id")
  Future<void> updateProduct(int id, String imageUrl, String title, String description, String price);

  @Query("DELETE FROM product_entity")
  Future<void> deleteProduct();

  @Query("SELECT * FROM product_entity WHERE loved = 1")
  Future<List<ProductEntity>> getLikedProducts();

  @Query("UPDATE product_entity SET loved = :loved WHERE id = :id")
  Future<void> updateLikedProduct(bool loved, int id);

  @Query("SELECT * FROM product_entity WHERE title LIKE :query")
  Future<List<ProductEntity>> searchProduct(String query);

  @Query("SELECT * FROM purchase_entity ORDER BY transaction_date DESC")
  Future<List<PurchaseEntity>> getPurchaseHistory();

  @Insert(onConflict : OnConflictStrategy.replace)
  Future<void> insertPurchaseHistory(PurchaseEntity item);

  @Query("DELETE FROM purchase_entity")
  Future<void> deletePurchaseHistory();
}