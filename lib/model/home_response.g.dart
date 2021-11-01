// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeResponse _$HomeResponseFromJson(Map<String, dynamic> json) => HomeResponse()
  ..data = json['data'] == null
      ? null
      : HomeInfo.fromJson(json['data'] as Map<String, dynamic>);

Map<String, dynamic> _$HomeResponseToJson(HomeResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

HomeInfo _$HomeInfoFromJson(Map<String, dynamic> json) => HomeInfo()
  ..category = (json['category'] as List<dynamic>)
      .map((e) => CategoryItem.fromJson(e as Map<String, dynamic>))
      .toList()
  ..productPromoList = (json['productPromo'] as List<dynamic>)
      .map((e) => ProductItem.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$HomeInfoToJson(HomeInfo instance) => <String, dynamic>{
      'category': instance.category,
      'productPromo': instance.productPromoList,
    };

CategoryItem _$CategoryItemFromJson(Map<String, dynamic> json) => CategoryItem()
  ..imageUrl = json['imageUrl'] as String
  ..id = json['id'] as int
  ..name = json['name'] as String;

Map<String, dynamic> _$CategoryItemToJson(CategoryItem instance) =>
    <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'id': instance.id,
      'name': instance.name,
    };

ProductItem _$ProductItemFromJson(Map<String, dynamic> json) => ProductItem()
  ..id = json['id'] as String
  ..imageUrl = json['imageUrl'] as String
  ..title = json['title'] as String
  ..description = json['description'] as String
  ..price = json['price'] as String
  ..loved = json['loved'] as int;

Map<String, dynamic> _$ProductItemToJson(ProductItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'loved': instance.loved,
    };
