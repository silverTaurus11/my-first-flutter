


import 'dart:core';

import 'package:floor/floor.dart';

@Entity(tableName: 'product_entity')
class ProductEntity {

  @PrimaryKey(autoGenerate: false)
  @ColumnInfo(name: 'id')
  int id = 0;

  @ColumnInfo(name: 'image_url')
  String imageUrl;

  @ColumnInfo(name : 'title')
  String title;

  @ColumnInfo(name : 'description')
  String description;

  @ColumnInfo(name : 'price')
  String price;

  @ColumnInfo(name : 'loved')
  int loved = 0;

  ProductEntity(this.id, this.imageUrl, this.title, this.description,
      this.price, this.loved);
}