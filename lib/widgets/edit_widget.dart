import 'package:auxiliar/providers/cart.dart' as cart;
import 'package:auxiliar/providers/cart.dart';
import 'package:auxiliar/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';

class EditWidget extends StatefulWidget {
  EditWidget({
    @required this.colore,
    @required this.statement,
    @required this.size,
    @required this.updateStatement,
    @required this.updateColore,
  });

  Colores colore;
  String statement;
  cart.Size size;
  Function updateStatement;
  Function updateColore;

  @override
  _EditWidgetState createState() => _EditWidgetState();
}

class _EditWidgetState extends State<EditWidget> {
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: ScreenUtil().setHeight(180),
        right: ScreenUtil().setWidth(30),
      ),
      child: Column(
        children: [
          Padding(
            child: IconButton(
                icon: Image.asset("flutter_assets/t_icon.png"),
                onPressed: () {
                  showGeneralDialog(
                      context: context,
                      barrierDismissible: true,
                      barrierLabel: MaterialLocalizations.of(context)
                          .modalBarrierDismissLabel,
                      barrierColor: Colors.black45,
                      transitionDuration: const Duration(milliseconds: 200),
                      pageBuilder: (BuildContext buildContext,
                          Animation animation, Animation secondaryAnimation) {
                        return Scaffold(
                          backgroundColor: Colors.black12,
                          body: Container(
                            width: ScreenUtil().setWidth(1080),
                            height: ScreenUtil().setHeight(1920),
                            padding: EdgeInsets.all(20),
                            color: Colors.black38,
                            child: Stack(
                              children: [
                                Align(
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    height: ScreenUtil().setHeight(1000),
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.text,
                                      onChanged: (newStatement) {
                                        widget.statement =
                                            newStatement.toUpperCase();
                                        widget
                                            .updateStatement(widget.statement);
                                      },
                                      onSubmitted: (_) {
                                        Navigator.of(context).pop();
                                      },
                                      controller: textController,
                                      maxLength: 45,
                                      decoration:
                                          InputDecoration(counterText: ''),
                                      style: TextStyle(
                                          fontFamily: "Headline Design",
                                          color: Colors.white,
                                          fontSize: 16),
                                      autofocus: true,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                }),
            padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(15)),
          ),
          Padding(
            child: IconButton(
                icon: Image.asset("flutter_assets/color_icon.png"),
                onPressed: () {
                  showGeneralDialog(
                      context: context,
                      barrierDismissible: true,
                      barrierLabel: MaterialLocalizations.of(context)
                          .modalBarrierDismissLabel,
                      barrierColor: Colors.black45,
                      transitionDuration: const Duration(milliseconds: 200),
                      pageBuilder: (BuildContext buildContext,
                          Animation animation, Animation secondaryAnimation) {
                        return Scaffold(
                          backgroundColor: Colors.black12,
                          body: Container(
                            width: ScreenUtil().setWidth(1080),
                            height: ScreenUtil().setHeight(1920),
                            padding: EdgeInsets.all(20),
                            color: Colors.black38,
                            child: Stack(
                              children: [
                                Align(
                                  child: Container(
                                    width: double.infinity,
                                    height: ScreenUtil().setHeight(1000),
                                    child: ListView.builder(
                                      itemCount: cart.Colores.values.length,
                                      itemBuilder: (ctx, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            widget.colore =
                                                cart.Colores.values[index];
                                            widget.updateColore(
                                                cart.Colores.values[index]);
                                            Navigator.of(context).pop();
                                          },
                                          child: ListTile(
                                            title: Text(
                                              cart.ColoresHelper
                                                  .coloresToString(cart
                                                      .Colores.values[index]),
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1
                                                  .copyWith(
                                                    color: widget.colore ==
                                                            cart.Colores
                                                                .values[index]
                                                        ? Theme.of(context)
                                                            .accentColor
                                                        : Colors.white,
                                                  ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                ),
                                Align(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        bottom: ScreenUtil().setHeight(240)),
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      icon: Icon(
                                        Icons.arrow_back_ios,
                                        size: 30,
                                      ),
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                  alignment: Alignment.bottomCenter,
                                )
                              ],
                            ),
                          ),
                        );
                      });
                }),
            padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(15)),
          ),
          Padding(
            child: IconButton(
                icon: Image.asset("flutter_assets/size_icon.png"),
                onPressed: () {
                  showGeneralDialog(
                      context: context,
                      barrierDismissible: true,
                      barrierLabel: MaterialLocalizations.of(context)
                          .modalBarrierDismissLabel,
                      barrierColor: Colors.black45,
                      transitionDuration: const Duration(milliseconds: 200),
                      pageBuilder: (BuildContext buildContext,
                          Animation animation, Animation secondaryAnimation) {
                        return Scaffold(
                          backgroundColor: Colors.black12,
                          body: Container(
                            width: ScreenUtil().setWidth(1080),
                            height: ScreenUtil().setHeight(1920),
                            padding: EdgeInsets.all(20),
                            color: Colors.black38,
                            child: Stack(
                              children: [
                                Align(
                                  child: Container(
                                    width: double.infinity,
                                    height: ScreenUtil().setHeight(1000),
                                    child: ListView.builder(
                                      itemCount: cart.Size.values.length,
                                      itemBuilder: (ctx, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            //setState(() {
                                            widget.size =
                                                cart.Size.values[index];
                                            Navigator.of(context).pop();
                                            //});
                                          },
                                          child: ListTile(
                                            title: Text(
                                              cart.SizeHelper.sizeToString(
                                                  cart.Size.values[index]),
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1
                                                  .copyWith(
                                                    color: widget.size ==
                                                            cart.Size
                                                                .values[index]
                                                        ? Theme.of(context)
                                                            .accentColor
                                                        : Colors.white,
                                                  ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                ),
                                Align(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        bottom: ScreenUtil().setHeight(240)),
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      icon:
                                          Icon(Icons.arrow_back_ios, size: 30),
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                  alignment: Alignment.bottomCenter,
                                )
                              ],
                            ),
                          ),
                        );
                      });
                }),
            padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(15)),
          ),
          Padding(
            child: IconButton(
                icon: Image.asset("flutter_assets/add_icon.png"),
                onPressed: () {
                  Provider.of<cart.Cart>(context, listen: false)
                      .addHoodie(widget.colore, widget.statement, widget.size);

                  Scaffold.of(context).hideCurrentSnackBar();
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Hoodie in the cart",
                      ),
                      duration: Duration(seconds: 1),
                      backgroundColor: Colors.black26,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(60),
                          topLeft: Radius.circular(60),
                        ),
                      ),
                    ),
                  );
                }),
            padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(15)),
          ),
        ],
      ),
    );
  }
}
