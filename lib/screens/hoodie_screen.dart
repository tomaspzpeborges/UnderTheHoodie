import 'package:auxiliar/providers/cart.dart' as cart;
import 'package:auxiliar/screens/cart_panel.dart';
import 'package:auxiliar/widgets/cart_item_widget.dart';
import 'package:auxiliar/widgets/edit_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HoodieScreen extends StatefulWidget {
  static const String routeName = "/hoodie_screen";

  @override
  _HoodieScreenState createState() => _HoodieScreenState();
}

class _HoodieScreenState extends State<HoodieScreen> {
  String statement = "UNDER THE HOODIE";
  cart.Colores colore = cart.Colores.mint;
  cart.Size size = cart.Size.L;

  void updateStatement(String newStatement) {
    setState(() {
      statement = newStatement;
    });
  }

  void updateColore(cart.Colores newColore) {
    setState(() {
      colore = newColore;
    });
  }

  //NOTE: WE DON'T NEED updateSize() BECAUSE IT DOES NOT AFFECT THE UI

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 1080, height: 1920, allowFontScaling: true);

    BorderRadiusGeometry radius = BorderRadius.only(
        topLeft: Radius.circular(30), topRight: Radius.circular(30));

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          body: SlidingUpPanel(
            minHeight: 75,
            maxHeight: 565,
            color: Theme.of(context).primaryColor.withOpacity(0.8),
            backdropEnabled: true,
            borderRadius: radius,
            collapsed: Container(
              //width: double.minPositive,
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: radius,
              ),
              child: Center(
                child: IconButton(
                  icon: Image.asset("flutter_assets/cart_icon.png"),
                  onPressed: () {},
                ),
              ),
            ),
            panel: CartPanel(),
            body: Stack(
              children: <Widget>[
                SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Image.asset("flutter_assets/light_purple.jpg"),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    //color: Colors.red,
                    width: double.infinity,
                    height: ScreenUtil().setHeight(1920),
                    child: Image.asset(
                      "flutter_assets/${cart.ColoresHelper.coloresToString(colore)}_hoodie.png",
                      fit: BoxFit.fitHeight,
                    ),
                    //),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: ScreenUtil().setHeight(350),
                      left: ScreenUtil().setWidth(220),
                      right: ScreenUtil().setWidth(220),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          statement.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Headline Design",
                            fontSize: ScreenUtil()
                                .setSp(48, allowFontScalingSelf: true),
                            //fontSize: 16,
                            color: Color.fromRGBO(28, 28, 28, 0.7),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 5,
                          ),
                          height: ScreenUtil().setHeight(25),
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: Image.asset("flutter_assets/logo2.png"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: EditWidget(
                      colore: colore,
                      statement: statement,
                      size: size,
                      updateStatement: updateStatement,
                      updateColore: updateColore),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
