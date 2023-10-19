import 'package:newapp/product_model.dart';

class CartItem {
  final Product selectedProduct;
  int quantity;

  CartItem(this.selectedProduct, this.quantity);
}
