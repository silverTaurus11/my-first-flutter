

import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:my_first_flutter/contract/home_activity_contract.dart';
import 'package:my_first_flutter/database/database.dart';
import 'package:my_first_flutter/database/my_database.dart';
import 'package:my_first_flutter/model/database/product_entity.dart';
import 'package:my_first_flutter/model/home_response.dart';
import 'package:my_first_flutter/my_helper.dart';
import 'package:my_first_flutter/webservice/api_service.dart';

class HomePresenter implements HomeActivityInteractor{
  HomeActivityView view;
  HomePresenter(this.view);

  RestClient api = RestClient(Dio());
  MyDatabase database = MyDatabase();

  StreamSubscription? dbStream;

  @override
  void retrieveCategories() async {
    await api.getHomeData().then((it) {
      if (it.isNotEmpty) {
        saveToLocal(it[0]);
      } else {
        view.toast("Data tidak ditemukan");
      }
    }).catchError((e) {
      log("Exception $e");
      view.toast("Terjadi kesalahan");
    });
  }

  @override
  void retrieveFavoriteProducts() {

  }

  @override
  void updateFavoriteProductItem(ProductEntity item) {
    dbStream = Stream.fromFuture(database.getDatabase())
        .asyncMap((db) => {
          if (db != null) {
            Stream.fromFuture(db.appDao.insertProduct(item))
            .listen((event) {
              showProducts(db);
            })
          }
        }).listen((event) { });
  }

  @override
  void saveToLocal(HomeResponse data) {
    var category = data.data?.category ?? <CategoryItem>[];
    view.showCategories(category);

    var product = data.data?.productPromoList ?? <ProductItem>[];
    dbStream = Stream.fromFuture(database.getDatabase())
        .asyncMap((db) => {
          if (db != null) {
            Stream.fromFuture(db.appDao.insertProducts(
              MyHelper.convertToProductEntityList(product)))
                .asyncMap((event) => showProducts(db))
                .listen((event) { },
                    onError: (e){
                      log("FailedSaveProducts $e");
                    })
          }})
        .listen((db) {});
  }

  void showProducts(AppDatabase db) async {
    await db.appDao.getProducts().then((value) {
            view.showProductItems(value);
          }).catchError((e) {
            log("FailedShowProducts $e");
          });
    }

  @override
  void finish() {
    dbStream?.cancel();
  }

}