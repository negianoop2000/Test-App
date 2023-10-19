import 'package:flutter/material.dart';
import 'package:newapp/product_model.dart';

class ProductProvider with ChangeNotifier {
  Product? _selectedProduct;

  Product? get selectedProduct => _selectedProduct;

  void selectProduct(Product product) {
    _selectedProduct = product;
    notifyListeners();
  }
}
