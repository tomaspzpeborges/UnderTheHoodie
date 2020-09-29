import 'package:auxiliar/screens/thank_you_screen.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart' as validator;

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

class TextForm extends StatefulWidget {
  @override
  _TextFormState createState() => _TextFormState();

  Cart cart;
}

class _TextFormState extends State<TextForm> {
  final _formKey = GlobalKey<FormState>();

  String name = "";
  String phone = "";
  String email = "";
  String address = "";
  String city = "";
  String zipCode = "";
  String town = "";

  final stripeKey = StripePayment.setOptions(
    StripeOptions(
        publishableKey:
            "INSERT PUBLIC STRIPE KEY HERE"),
  );

  final HttpsCallable INTENT =
      CloudFunctions(region: "us-central1").getHttpsCallable(
    functionName: 'createPaymentIntent',
  );

  @override
  Widget build(BuildContext context) {
    final halfMediaWidth = MediaQuery.of(context).size.width / 2.0;
    widget.cart = Provider.of<Cart>(context, listen: false);

    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.topCenter,
                    width: halfMediaWidth,
                    child: MyTextFormField(
                      hintText: 'Name',
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'enter your name';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        name = value;
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    width: halfMediaWidth,
                    child: MyTextFormField(
                      hintText: 'Phone',
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'enter your phone number';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        phone = value;
                      },
                    ),
                  )
                ],
              ),
            ),
            MyTextFormField(
              hintText: 'Email',
              isEmail: true,
              validator: (String value) {
                if (!validator.isEmail(value)) {
                  return 'enter a valid email';
                }
                return null;
              },
              onSaved: (String value) {
                email = value;
              },
            ),
            MyTextFormField(
              hintText: 'Address',
              isEmail: false,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'enter your address';
                }
                return null;
              },
              onSaved: (String value) {
                address = value;
              },
            ),
            Container(
              alignment: Alignment.topCenter,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.topCenter,
                    width: halfMediaWidth,
                    child: MyTextFormField(
                      hintText: 'City',
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'enter your city';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        city = value;
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    width: halfMediaWidth,
                    child: MyTextFormField(
                      hintText: 'Zip Code',
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'enter your zip code';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        zipCode = value;
                      },
                    ),
                  )
                ],
              ),
            ),
            MyTextFormField(
              hintText: 'Town/District',
              isEmail: false,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'enter your town/district';
                }
                return null;
              },
              onSaved: (String value) {
                town = value;
              },
            ),
            Container(
              padding: EdgeInsets.only(
                top: 30,
              ),
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState
                        .save(); //this calls the onSave Field from TestFormField

                    try {
                      StripePayment.paymentRequestWithCardForm(
                              CardFormPaymentRequest())
                          .then((paymentMethod) {
                        double amount = widget.cart.finalPrice *
                            100.0; // multiplying with 100 to change $ to cents
                        INTENT.call(<String, dynamic>{
                          'amount': amount,
                          'currency': 'eur'
                        }).then((response) {
                          print(response.data.toString());
                          confirmDialog(
                            response.data["client_secret"],
                            paymentMethod,
                          ); //function for confirmation for payment
                        });
                      });
                    } on CloudFunctionsException catch (e) {
                      print(
                          'Cloud functions exception with code: ${e.code}, and Details: ${e.details}, with message: ${e.message} ');
                    } catch (e) {
                      print(e.toString());
                    }
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                color: Theme.of(context).primaryColor,
                child: Text(
                  "Pay with Card ${widget.cart.finalPrice}€".toUpperCase(),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            Container(
              //color: Colors.red,
              height: ScreenUtil().setHeight(50),
              child: FittedBox(
                fit: BoxFit.cover,
                child: Image.asset("flutter_assets/powered_by_stripe.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  confirmDialog(
    String clientSecret,
    PaymentMethod paymentMethod,
  ) {
    var confirm = AlertDialog(
      backgroundColor: Colors.white,
      title: Text("Confirm Payment"),
      content: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Amount: ${widget.cart.finalPrice}€"),
          ],
        ),
      ),
      actions: <Widget>[
        ButtonBar(
          alignment: MainAxisAlignment.spaceBetween,
          children: [
            new RaisedButton(
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: new Text(
                'CANCEL',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                final snackBar = SnackBar(
                  content: Text('Payment Cancelled'),
                );
                Scaffold.of(context).showSnackBar(snackBar);
              },
            ),
            new RaisedButton(
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: new Text(
                'CONFIRM',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                confirmPayment(
                    clientSecret, paymentMethod); // function to confirm Payment
              },
            ),
          ],
        )
      ],
    );
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return confirm;
        });
  }

  confirmPayment(String sec, PaymentMethod paymentMethod) {
    StripePayment.confirmPaymentIntent(
      PaymentIntent(clientSecret: sec, paymentMethodId: paymentMethod.id),
    ).then((val) {
      addDetailsToFirestore(); //Function to add Payment details to firestore
      //final snackBar = SnackBar(content: Text('Payment Successful'),);
      //Scaffold.of(context).showSnackBar(snackBar);
      Navigator.pushReplacementNamed(context, ThankYouScreen.routeName);
    });
  }

  void addDetailsToFirestore() {
    final firestoreInstance = Firestore.instance;
    String currentId;

    firestoreInstance.collection("orders").add({
      'address': address,
      'city': city,
      "email": email,
      "name": name,
      "phone": phone,
      "price": widget.cart.finalPrice,
      "town": town,
      "zipCode": zipCode,
    }).then((value) {
      currentId = value.documentID;
      print(value.documentID);
      widget.cart.hoodies.forEach((hoodie) {
        firestoreInstance
            .collection("orders")
            .document(value.documentID)
            .collection("hoodies")
            .add({
          "color": ColoresHelper.coloresToString(hoodie.colore),
          "quantity": hoodie.quantity.toString(),
          "size": SizeHelper.sizeToString(hoodie.size),
          "statement": hoodie.statement,
        });
      });
    });
  }
}

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final Function validator;
  final Function onSaved;
  final bool isEmail;

  MyTextFormField({
    this.hintText,
    this.validator,
    this.onSaved,
    this.isEmail = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.all(15.0),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[200],
        ),
        validator: validator,
        onSaved: onSaved,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      ),
    );
  }
}
