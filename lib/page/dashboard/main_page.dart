import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_flutter/contract/home_activity_contract.dart';
import 'package:my_first_flutter/model/database/product_entity.dart';
import 'package:my_first_flutter/model/home_response.dart';
import 'package:my_first_flutter/model/profile_item.dart';
import 'package:my_first_flutter/my_helper.dart';
import 'package:my_first_flutter/page/base_page.dart';
import 'package:my_first_flutter/page/dashboard/firebase_main_page.dart';
import 'package:my_first_flutter/page/dashboard/home_page.dart';
import 'package:my_first_flutter/page/dashboard/profile_page.dart';
import 'package:my_first_flutter/presenter/home_presenter.dart';

class MainPage extends BasePage{
  static const routeName = '/main_page';

  ProfileItem? profileItem;

  MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends BasePageState<MainPage> implements HomeActivityView {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  late HomePresenter homePresenter;
  HomeInfo items = HomeInfo();
  List<ProductEntity> products = <ProductEntity>[];

  @override
  void initState() {
    super.initState();
    MyHelper.getProfileItemFromLocal()
        .then((value) => {
          widget.profileItem = value
    });

    homePresenter = HomePresenter(this);
    homePresenter.retrieveCategories();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onFavoriteTapped(ProductEntity item){
    log("Favorite Tap");
    homePresenter.updateFavoriteProductItem(item);
  }

  @override
  Widget createLayout(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      HomePage.builds(context, items, products, _onFavoriteTapped),
      FirebaseMainPage.builds(context),
      ProfilePage.builds(context, widget.profileItem ?? ProfileItem())
    ];

    return Scaffold(
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Firebase',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.cyan[800],
        onTap: _onItemTapped,
      ),
    );
  }

  @override
  void showCategories(List<CategoryItem>? categories) async {
    setState(() {
      items.category = categories ?? <CategoryItem>[];
    });
  }

  @override
  void showProductItems(List<ProductEntity>? productItem) async {
    setState(() {
      products = productItem ?? <ProductEntity>[];
    });
  }

  @override
  void successUpdateFavoriteProductItem(ProductItem? item) async{

  }

  @override
  void toast(String message) {

  }

}