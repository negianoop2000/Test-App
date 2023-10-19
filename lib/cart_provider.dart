import 'package:flutter/material.dart';
import 'package:newapp/cartitem_model.dart';
import 'package:newapp/product_model.dart';


class CartProvider extends ChangeNotifier {
  List<CartItem> cartItems = [];

  void addToCart(Product product) {
    bool found = false;
    for (var item in cartItems) {
      if (item.selectedProduct.id == product.id) {
        item.quantity++;
        found = true;
        break;
      }
    }

    if (!found) {
      cartItems.add(CartItem(product, 1));
    }

    notifyListeners();
  }
}
