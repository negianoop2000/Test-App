import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newapp/cart_provider.dart';
import 'package:newapp/plaform_channel.dart';
import 'package:newapp/product_provider.dart';
import 'package:newapp/upipayment_page.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter/services.dart';
class Product_Details extends StatefulWidget {
  const Product_Details({Key? key});

  @override
  State<Product_Details> createState() => _Product_DetailsState();
}

class _Product_DetailsState extends State<Product_Details> {
  Map<String, dynamic>? paymentIntentData;

  void turnOnFlashlight() async {
    const channel = MethodChannel('flashlight');
    try {
      await channel.invokeMethod('turnOnFlashlight');
    } on PlatformException catch (e) {
      // Handle errors here
      print("Error: ${e.message}");
    }
  }


  Future<void> makePayment() async {
    final productProvider = Provider.of<ProductProvider>(context,listen: false);
    final selectedProduct = productProvider.selectedProduct;
    try {
      paymentIntentData =
      await createPaymentIntent("${selectedProduct?.price.toStringAsFixed(2)}", 'USD');

      await Stripe.instance
          .initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              setupIntentClientSecret: 'sk_test_51O9ocZSEXjZl3XWmrhdXbpp93KcrNxvgf6ujSTjbjY07RscPcALWqkv6AEarpHoYnwK2qosQKiuK1JQ2SP3BzbV800tNUAr07F',
              paymentIntentClientSecret:
              paymentIntentData!['client_secret'],
              //applePay: PaymentSheetApplePay.,
              //googlePay: true,
              //testEnv: true,
              customFlow: true,
              style: ThemeMode.dark,
              // merchantCountryCode: 'US',
              merchantDisplayName: 'Paytm'))
          .then((value) {});

      displayPaymentSheet();
    } catch (e, s) {
      print('Payment exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet(

      )
          .then((newValue) {
        print('payment intent' + paymentIntentData!['id'].toString());
        print(
            'payment intent' + paymentIntentData!['client_secret'].toString());
        print('payment intent' + paymentIntentData!['amount'].toString());
        print('payment intent' + paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());
        ScaffoldMessenger.of(context as BuildContext)
            .showSnackBar(const SnackBar(content: Text("paid successfully")));

        paymentIntentData = null;
      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
            content: Text("Cancelled "),
          ));
    } catch (e) {
      print('$e');
    }
  }


  Future<Map<String, dynamic>> createPaymentIntent(String amount, String currency) async {
    try {
      // Convert the amount to cents and format it as a string
      final intAmountInCents = (double.parse(amount) * 100).toInt();
      final amountString = intAmountInCents.toString();

      Map<String, dynamic> body = {
        'amount': amountString,  // Send the amount as a string
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer ' + 'sk_test_51O9ocZSEXjZl3XWmrhdXbpp93KcrNxvgf6ujSTjbjY07RscPcALWqkv6AEarpHoYnwK2qosQKiuK1JQ2SP3BzbV800tNUAr07F',
            'Content-Type': 'application/x-www-form-urlencoded'
          });

      print('Create Intent response ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('Error charging user: $err');
      return Future.error('An error occurred while creating a payment intent');
    }
  }




  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context,listen: false);
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
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 10),
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
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Category: ${selectedProduct.category}",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[900],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Description: ${selectedProduct.description}",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  turnOnFlashlight();
                  final cartProvider = Provider.of<CartProvider>(context, listen: false);
                  cartProvider.addToCart(selectedProduct);

                  // Call the platform channel to show a message
                  PlatformChannel.showMessage('Product added to cart');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
                child: const Text("Add to Cart"),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () async {
                // await makePayment();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpiPaymentScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  width: double.infinity -20,
                  decoration: BoxDecoration(
                    color: Colors.green[400],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      'Buy',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}