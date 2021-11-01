
import 'dart:convert';
import 'dart:developer';

import 'package:my_first_flutter/model/database/product_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/home_response.dart';
import 'model/profile_item.dart';

class MyHelper{

  static saveProfileItemToLocal(ProfileItem profileItem) async {
    String profileItemString = jsonEncode(profileItem.toJson());
    await SharedPreferences.getInstance().then((prefs) {
      log(profileItemString);
      prefs.setString('PROFILE_ITEM', profileItemString);
    });
  }

  static Future<ProfileItem?> getProfileItemFromLocal() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    var dataString = myPrefs.getString('PROFILE_ITEM') ?? "";
    log(dataString);
    if (dataString.isNotEmpty) {
      return ProfileItem.fromJson(jsonDecode(dataString));
    }
    return null;
  }

  static List<ProductEntity> convertToProductEntityList(List<ProductItem> product){
    var products = <ProductEntity>[];
    for(var i = 0 ; i < product.length; i++) {
      var productEntity = ProductEntity(
          int.parse(product[i].id),
          product[i].imageUrl,
          product[i].title,
          product[i].description,
          product[i].price,
          product[i].loved
      );
      products.add(productEntity);
    }
    return products;
  }

  static Stream<T> flattenStreamsOfFutures<T>(Stream<Future<T>> source) async* {
    await for (var future in source) {
      try {
        yield await future;
      } catch (error, stack) {
        yield* Stream.error(error, stack);
      }
    }
  }
}