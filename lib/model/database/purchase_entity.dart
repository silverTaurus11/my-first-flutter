
import 'package:floor/floor.dart';
import 'package:my_first_flutter/model/database/product_entity.dart';

@Entity(
    tableName: 'purchase_entity',
    foreignKeys: [
      ForeignKey(childColumns: ['product_id'], parentColumns: ['id'], entity: ProductEntity)
    ])
class PurchaseEntity {
  @PrimaryKey(autoGenerate : true)
  @ColumnInfo(name : 'purchase_id')
  int id = 0;

  @ColumnInfo(name: 'product_id')
  int productId = 0;

  @ColumnInfo(name : 'qty')
  int qty = 0;

  @ColumnInfo(name : 'transaction_date')
  int dateInMillis = 0;

  PurchaseEntity(this.id, this.productId, this.qty, this.dateInMillis);
}