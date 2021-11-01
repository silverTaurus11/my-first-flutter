
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_flutter/model/database/product_entity.dart';
import 'package:my_first_flutter/model/home_response.dart';
import 'package:my_first_flutter/style.dart';

class HomePage {

  static Widget builds(BuildContext context, HomeInfo item, List<ProductEntity> products,
      Function(ProductEntity) tap){
    return Column(
      children: <Widget>[
        Flexible(
            child: SizedBox(
              height: 160,
              child: categoriesBuild(context, item.category),
            )),
        Expanded(
            flex: 3,
            child:  productsBuild(context, products, tap))
      ],
    );
  }

  static Widget categoriesBuild(BuildContext context, List<CategoryItem> categoryItem){
    return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, position){
              return Card(
                clipBehavior: Clip.hardEdge,
                child: Padding(padding: const EdgeInsets.only(
                    top: 10,
                    left: 3,
                    right: 3),
                  child: Column(
                    children: <Widget>[
                      Image.network(
                        categoryItem[position].imageUrl,
                        width: 100,
                        height: 100,),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      Text(
                          categoryItem[position].name,
                          style: CustomStyle.formEditText(context))
                    ],
                  )),
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              );
            },
            itemCount: categoryItem.length,
            scrollDirection: Axis.horizontal
        );
  }

  static Widget productsBuild(BuildContext context, List<ProductEntity> productItem,
      Function(ProductEntity) tap){
    return ListView.builder(
        itemBuilder: (context, position){
          return Card(
            child: Padding(padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: 3,
                right: 3),
              child: Stack(
                  alignment: const Alignment(1, 1),
                  children: <Widget>[
                    Container(
                      child: Column(children: <Widget>[
                        AspectRatio(aspectRatio: 2/1,
                            child: Image.network(productItem[position].imageUrl,
                                fit: BoxFit.fill)),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        Text(
                            productItem[position].title,
                            style: CustomStyle.formEditText(context))
                      ]),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10, bottom: 5),
                      alignment: Alignment.bottomLeft,
                      child: IconButton(
                        iconSize: 36,
                        icon: 1 == productItem[position].loved ? Image.asset("lib/assets/icon/heart_enable.png")
                        : Image.asset(("lib/assets/icon/heart_disable.png")
                      ), onPressed: () {
                          ProductEntity newItem = productItem[position];
                          newItem.loved = 1 == newItem.loved ? 0 : 1;
                        tap(newItem);
                      }
                    ))
              ]),),
            elevation: 3.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          );
        },
        itemCount: productItem.length,
        scrollDirection: Axis.vertical
    );
  }

}