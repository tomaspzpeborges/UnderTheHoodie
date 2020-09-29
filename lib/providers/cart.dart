import 'package:flutter/material.dart';

enum Colores {
  mint,
  silver,
}

extension ColoresHelper on Colores {
  static String coloresToString(Colores colore) {
    switch (colore) {
      case Colores.silver:
        return "silver";
        break;
      case Colores.mint:
        return "mint";
        break;
      default:
        return "white";
        break;
    }
  }

  static Color coloresToColor(Colores colore) {
    switch (colore) {
      case Colores.silver:
        return Color.fromRGBO(192, 192, 192, 1);
        break;
      case Colores.mint:
        return Color.fromRGBO(195, 225, 220, 1);
        break;
      default:
        return Colors.white;
        break;
    }
  }
}

enum Size { XS, S, M, L, XL }

extension SizeHelper on Size {
  static String sizeToString(Size size) {
    switch (size) {
      case Size.XS:
        return "XS";
        break;
      case Size.S:
        return "S";
        break;
      case Size.M:
        return "M";
        break;
      case Size.L:
        return "L";
        break;
      case Size.XL:
        return "XL";
        break;
      default:
        return "M";
        break;
    }
  }
}

class CartItem {
  final String id;
  int quantity;

  final Colores colore;
  final String statement;
  final Size size;

  //final double price;

  CartItem({
    @required
        this.id, //CartItem id different than the id of the product it belongs to
    @required this.quantity,
    @required this.colore,
    @required this.statement,
    @required this.size,
  });
}

class Cart extends ChangeNotifier {
  static const PRICE = 49;
  List<CartItem> _hoodies = [];

  List<CartItem> get hoodies {
    return [..._hoodies];
  }

  int get cartItemCount {
    return _hoodies.length;
  }

  int get hoodiesAmount {
    var count = 0;
    _hoodies.forEach((hoodie) {
      count += hoodie.quantity;
    });

    return count;
  }

  double get finalPrice {
    var finalPrice = 0.0;

    _hoodies.forEach((hoodie) {
      finalPrice += hoodie.quantity * PRICE;
    });

    return finalPrice;
  }

  void addHoodie(Colores colore, String statement, Size size) {
    CartItem hoodie = _hoodies.firstWhere((hoodie) {
      return ((hoodie.statement == statement) &&
          (hoodie.colore == colore) &&
          (hoodie.size == size));
    }, orElse: () {
      CartItem newHoodie = CartItem(
          quantity: 0,
          colore: colore,
          size: size,
          statement: statement,
          id: DateTime.now().toString());

      _hoodies.add(newHoodie);
      return newHoodie;
    });
    hoodie.quantity++;

    notifyListeners();
    //print(hoodies.length);
  }

  void removeHoodie(String hoodieId) {
    _hoodies.removeWhere((hoodie) => hoodie.id == hoodieId);
    notifyListeners();
  }

  void clear() {
    _hoodies = [];
    notifyListeners();
  }
}
