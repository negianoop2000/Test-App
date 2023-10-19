import 'package:flutter/material.dart';
import 'package:newapp/cartitem_model.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart'; // Import your CartProvider

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    List<CartItem> cartItems = cartProvider.cartItems;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
        backgroundColor: Colors.purple[200],
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: double.infinity,
              height: 100,
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 80,
                    height: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.network(
                        item.selectedProduct.image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                           item.selectedProduct.title,
                            style: const TextStyle(fontSize: 15
                                ,fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Price: \$${item.selectedProduct.price.toStringAsFixed(2)}",
                            style: const TextStyle(fontSize: 15,
                                color: Colors.green),
                          ),
                          Text(
                              'Quantity: ${item.quantity.toString()}',
                            style: const TextStyle(fontSize: 15,
                                color: Colors.red
                                ,fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
