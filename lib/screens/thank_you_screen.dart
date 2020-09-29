import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;

import 'package:flutter_screenutil/screenutil.dart';

class ThankYouScreen extends StatelessWidget {
  static const String routeName = "/thank_you_screen";

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: SafeArea(
        child: Scaffold(
          appBar: Platform.isIOS ? CupertinoNavigationBar() : AppBar(),
          resizeToAvoidBottomPadding: false,
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    bottom: 10,
                  ),
                  height: ScreenUtil().setHeight(150),
                  //width: ScreenUtil().setHeight(400) ,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Image.asset("flutter_assets/logo2.png"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 12,
                  ),
                  child: Text(
                    "UNDER THE HOODIE",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Headline Design",
                      fontSize:
                          ScreenUtil().setSp(40, allowFontScalingSelf: true),
                      color: Colors.black,
                    ),
                  ),
                ),
                Text("THANK YOU FOR YOUR PURCHASE.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2),
                Text("You will be contacted soon.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
