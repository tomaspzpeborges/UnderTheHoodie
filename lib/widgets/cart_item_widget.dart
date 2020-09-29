import 'dart:math';

import 'package:auxiliar/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem hoodie;
  final bool singleHoodie;
  final bool noHoodie;

  const CartItemWidget({
    this.hoodie,
    this.singleHoodie = false,
    this.noHoodie = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (singleHoodie || noHoodie)
          ? ScreenUtil().setWidth(1080)
          : ScreenUtil().setWidth(642),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: (singleHoodie || noHoodie)
                  ? ScreenUtil().setWidth(1000)
                  : ScreenUtil().setWidth(600),
              height: 350,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    noHoodie
                        ? Theme.of(context).accentColor
                        : ColoresHelper.coloresToColor(hoodie.colore),
                    Colors.white
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 16),
                      blurRadius: 8),
                ],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Stack(
                children: noHoodie
                    ? <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.all(
                              ScreenUtil().setWidth(60),
                            ),
                            child: Text(
                              "empty cart, crazy ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(color: Colors.black38),
                            ),
                          ),
                        ),
                      ]
                    : <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
                            child: IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: Colors.black26,
                              ),
                              onPressed: () {
                                Provider.of<Cart>(context, listen: false)
                                    .removeHoodie(hoodie.id);
                              },
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.all(
                              ScreenUtil().setWidth(60),
                            ),
                            child: Text(
                              hoodie.statement,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                //wordSpacing: 2,
                                fontFamily: "Headline Design",
                                color: Color.fromRGBO(28, 28, 28, 0.7),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.all(
                              ScreenUtil().setWidth(60),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "SIZE: ",
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                    Text(SizeHelper.sizeToString(hoodie.size),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2),
                                  ],
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(20),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("QTY: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2),
                                    Text("${hoodie.quantity}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
