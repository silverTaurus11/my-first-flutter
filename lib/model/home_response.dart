

import 'package:json_annotation/json_annotation.dart';
import 'package:my_first_flutter/model/database/product_entity.dart';

part 'home_response.g.dart';


@JsonSerializable()
class HomeResponse{
  @JsonKey(name: "data")
  HomeInfo? data;

  HomeResponse();

  factory HomeResponse.fromJson(Map<String, dynamic> json) => _$HomeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);
}

@JsonSerializable()
class HomeInfo{
  @JsonKey(name: "category")
  List<CategoryItem> category =  <CategoryItem>[];
  @JsonKey(name: "productPromo")
  List<ProductItem> productPromoList = <ProductItem>[];

  HomeInfo();

  factory HomeInfo.fromJson(Map<String, dynamic> json) => _$HomeInfoFromJson(json);

  Map<String, dynamic> toJson() => _$HomeInfoToJson(this);
}

@JsonSerializable()
class CategoryItem {
  @JsonKey(name: "imageUrl")
  String imageUrl = "";
  @JsonKey(name: "id")
  int id = 0;
  @JsonKey(name: "name")
  String name = "";

  CategoryItem();

  factory CategoryItem.fromJson(Map<String, dynamic> json) => _$CategoryItemFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryItemToJson(this);
}

@JsonSerializable()
class ProductItem{
  @JsonKey(name: "id")
  String id = "";
  @JsonKey(name: "imageUrl")
  String imageUrl = "";
  @JsonKey(name: "title")
  String title = "";
  @JsonKey(name: "description")
  String description = "";
  @JsonKey(name: "price")
  String price = "";
  @JsonKey(name: "loved")
  int loved = 0;

  ProductItem();

  factory ProductItem.fromJson(Map<String, dynamic> json) => _$ProductItemFromJson(json);

  Map<String, dynamic> toJson() => _$ProductItemToJson(this);
}