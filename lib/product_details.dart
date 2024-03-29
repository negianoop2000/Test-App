import 'package:flutter/material.dart';
import 'package:newapp/cart_provider.dart';
import 'package:newapp/plaform_channel.dart';
import 'package:newapp/product_provider.dart';
import 'package:provider/provider.dart';

class Product_Details extends StatefulWidget {
  const Product_Details({Key? key});

  @override
  State<Product_Details> createState() => _Product_DetailsState();
}

class _Product_DetailsState extends State<Product_Details> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final selectedProduct = productProvider.selectedProduct;

    if (selectedProduct == null) {


      // Handle the case when no product is selected.
      return Center(child: Text("No product selected"));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        title: Text("Product Detail"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Center(
                child: Hero(
                  tag: 'product_${selectedProduct.id}',
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.network(
                        selectedProduct.image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Id: ${selectedProduct.id}",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Title: ${selectedProduct.title}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Price: \$${selectedProduct.price.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 10),


              Text(
                "Category: ${selectedProduct.category}",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[900],
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Description: ${selectedProduct.description}",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  final cartProvider = Provider.of<CartProvider>(context, listen: false);
                  cartProvider.addToCart(selectedProduct);

                  // Call the platform channel to show a message
                  PlatformChannel.showMessage('Product added to cart');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
                child: const Text("Add to Cart"),
              )

            ],
          ),
        ),
      ),
    );
  }
}