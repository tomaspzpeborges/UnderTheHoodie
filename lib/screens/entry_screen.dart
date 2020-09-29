import 'package:auxiliar/screens/hoodie_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';
//import 'package:video_player/video_player.dart';

//import 'package:video_player/video_player.dart';

class EntryScreen extends StatefulWidget {
  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 1080, height: 1920, allowFontScaling: true);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Image.asset(
                    "flutter_assets/clouds.jpg",
                  ),
                ), //
              ),
              Center(
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        //color: Colors.red,
                        margin: EdgeInsets.only(
                          bottom: 15,
                        ),
                        height: ScreenUtil().setHeight(150),
                        //width: ScreenUtil().setHeight(400) ,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Image.asset("flutter_assets/logo2.png"),
                        ),
                      ),
                      Text(
                        "UNDER THE HOODIE",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Headline Design",
                          fontSize: ScreenUtil()
                              .setSp(48, allowFontScalingSelf: true),
                          //fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    //child: Container(),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        padding:
                            EdgeInsets.only(top: ScreenUtil().setHeight(30)),
                        child: Text(
                          "Boozout Group, Made in Porto",
                          style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 10)
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GoButton(),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GoButton extends StatelessWidget {
  const GoButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacementNamed(HoodieScreen.routeName);
      },
      child: Container(
        width: 70, //ScreenUtil().setWidth(200),
        height: 70, //ScreenUtil().setHeight(200),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Theme.of(context).primaryColor,
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            "GO",
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  fontSize: 20,
                ),
          ),
        ),
      ),
    );
  }
}
