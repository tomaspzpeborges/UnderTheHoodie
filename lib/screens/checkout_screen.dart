import 'package:auxiliar/providers/cart.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:provider/provider.dart';
import '../widgets/text_form.dart';

import 'package:validators/validators.dart' as validator;


class CheckoutScreen extends StatefulWidget {
  static const String routeName = "/checkout_screen";

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {



  @override
  Widget build(BuildContext context) {

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: SafeArea(
        child: Scaffold(
          appBar: Platform.isIOS ? CupertinoNavigationBar() : AppBar(),
          resizeToAvoidBottomPadding: false,
          body: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: TextForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

