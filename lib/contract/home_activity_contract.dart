import 'package:my_first_flutter/model/database/product_entity.dart';
import 'package:my_first_flutter/model/home_response.dart';

class HomeActivityInteractor {
  void retrieveCategories(){}
  void retrieveFavoriteProducts(){}
  void updateFavoriteProductItem(ProductEntity item){}
  void saveToLocal(HomeResponse data){}
  void finish(){}
}

class HomeActivityView{
  void toast(String message){}
  void showCategories(List<CategoryItem>? categories){}
  void showProductItems(List<ProductEntity>? productItem){}
  void successUpdateFavoriteProductItem(ProductItem? item){}
}