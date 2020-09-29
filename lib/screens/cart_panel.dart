import 'package:auxiliar/providers/cart.dart';
import 'package:auxiliar/screens/checkout_screen.dart';
import 'package:auxiliar/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class CartPanel extends StatefulWidget {
  @override
  _CartPanelState createState() => _CartPanelState();
}

class _CartPanelState extends State<CartPanel> {
  @override
  Widget build(BuildContext context) {
    final cart1 = Provider.of<Cart>(context);

    return Stack(
      children: [
        Column(
          children: [
            Container(
              //height: 75,
              //width: double.minPositive,
              decoration: BoxDecoration(
                  //color: Theme.of(context).accentColor.withOpacity(0.8),
                  borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              )),
              child: Padding(
                padding: EdgeInsets.only(top: 12.5),
                child: Center(
                  child: IconButton(
                    icon: Image.asset("flutter_assets/cart_icon.png"),
                    //Icon(Icons.shopping_cart, color: Color.fromRGBO(255, 255, 255, 0.8), size: 35,),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            //Align(alignment: Alignment.center,
            Container(
              height: 400,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                //controller: scrollController,
                itemCount: cart1.hoodies.length == 0 ? 1 : cart1.hoodies.length,
                itemBuilder: (BuildContext context, int index) {
                  //return ListTile(title: Text('Item $index'));
                  return CartItemWidget(
                    hoodie:
                        cart1.hoodies.length == 0 ? null : cart1.hoodies[index],
                    singleHoodie: cart1.hoodies.length == 1 ? true : false,
                    noHoodie: cart1.hoodies.length == 0 ? true : false,
                  );
                },
              ),
            ),
          ],
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  child: ListTile(
                    title: Text(
                      "Total",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(fontSize: 18),
                    ),
                    trailing: Text("${cart1.finalPrice.toStringAsFixed(2)}€",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(fontSize: 18)),
                  ),
                ),
                Container(
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    onPressed: () {
                      if (cart1.hoodies.length != 0) {
                        Navigator.of(context)
                            .pushNamed(CheckoutScreen.routeName);
                      } else {
                        Scaffold.of(context).hideCurrentSnackBar();
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Empty Cart",
                            ),
                            duration: Duration(seconds: 1),
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(60),
                                topLeft: Radius.circular(60),
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    color: Color.fromRGBO(0, 0, 0, 1),
                    //textColor: Colors.white,
                    child: Text(
                      "CHECKOUT".toUpperCase(),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  padding: EdgeInsets.only(
                    right: ScreenUtil().setWidth(30),
                    left: ScreenUtil().setWidth(30),
                    bottom: ScreenUtil().setWidth(30),
                  ),
                  width: double.infinity,
                  //color: Colors.blue,
                ),
              ],
            ),
        ),
      ],
    );
  }
}
