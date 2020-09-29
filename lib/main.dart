import 'package:auxiliar/providers/cart.dart';
import 'package:auxiliar/screens/checkout_screen.dart';
import 'package:auxiliar/screens/hoodie_screen.dart';
import 'package:auxiliar/screens/thank_you_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/entry_screen.dart';

import 'package:flutter/services.dart';

import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import './screens/entry_screen.dart';
import 'helpers/custom_route.dart';

void main() => runApp(App());

//DevicePreview.DevicePreview (builder: (context) =>
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        )
      ],
      child: MaterialApp(
        //home: EntryScreen(),
        home: EntryScreen(),
        theme: ThemeData(
          primaryColor: Color.fromRGBO(174, 184, 254, 1), //purpleblue
          accentColor: Color.fromRGBO(247, 219, 167, 1), //goldenbeige
          fontFamily: "CustomIcons",
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
                bodyText2: TextStyle(color: Colors.black, fontSize: 14),
              ),
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CustomPageTransitionBuilder(),
            TargetPlatform.iOS: CustomPageTransitionBuilder(),
          }),
        ),

        routes: {
          HoodieScreen.routeName: (ctx) => HoodieScreen(),
          CheckoutScreen.routeName: (ctx) => CheckoutScreen(),
          ThankYouScreen.routeName: (ctx) => ThankYouScreen(),
        },
      ),
    );
  }
}
