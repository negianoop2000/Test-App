import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:newapp/cart_page.dart';
import 'package:newapp/product_model.dart';
import 'package:newapp/product_provider.dart';
import 'package:newapp/product_details.dart';
import 'package:newapp/signup.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:shimmer/shimmer.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Firebase Services/google_signin.dart';
class Product_List extends StatefulWidget {
  const Product_List({super.key});

  @override
  State<Product_List> createState() => _Product_ListState();
}

class _Product_ListState extends State<Product_List> {
  bool isLoading = false;
  final String apiURL = "https://fakestoreapi.com/products";
  final String hiveBoxName = "products";
  final TextEditingController _searchController = TextEditingController();
  List<Product> data = [];
  List<Product> filteredData = [];

  @override
  void initState() {
    super.initState();
    fetchData();


  }

  Future<Widget> loadAndDisplayImage() async {
    String imagePath = 'img1.png'; // Replace with the actual path to your image in Firebase Storage

    // Create a reference to the Firebase Storage location of the image.
    Reference storageRef = FirebaseStorage.instance.ref().child(imagePath);

    // Get the download URL of the image.
    String downloadURL = await storageRef.getDownloadURL();

    // Use the download URL to load and display the image using the Image.network widget.
    return Image.network(downloadURL);
  }

  void filterProducts(String query) {
    setState(() {
      filteredData = data
          .where((product) =>
          product.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(apiURL));
      print("api");
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        final List<Product> productList = jsonList.map((json) => Product.fromJson(json)).toList();

        final productsBox = await Hive.openBox<Product>(hiveBoxName);

        // Save data to Hive
        await productsBox.clear();
        await productsBox.addAll(productList);
        print("data saved");
        setState(() {
          data = productList;
          isLoading = false;
        });
      } else {
        final productsBox = await Hive.openBox<Product>(hiveBoxName);
        print("store");
        if (productsBox.isNotEmpty) {
          // If there is data in Hive, load it
          setState(() {
            data = productsBox.values.toList();
            isLoading = false;
          });
        } else {
          // Handle the case when both API and Hive data are unavailable
          setState(() {
            isLoading = false;
          });
        }
      }
    } catch (e) {
      // Handle API request errors, such as no internet connection
      final productsBox = await Hive.openBox<Product>(hiveBoxName);

      if (productsBox.isNotEmpty) {
        // If there is data in Hive, load it
        setState(() {
          data = productsBox.values.toList();
          isLoading = false;
        });
      } else {
        // Handle the case when both API and Hive data are unavailable
        setState(() {
          isLoading = false;
        });
      }
    }
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        title: Text("Product List"),
        actions:
           [
            FutureBuilder<Widget>(
              future: loadAndDisplayImage(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return snapshot.data ?? Text("Image not found");
                } else if (snapshot.hasError) {
                  return Text("Error loading image");
                } else {
                  return CircularProgressIndicator(); // Show a loading indicator while the image is being fetched.
                }
              },
            ),
            IconButton(
              onPressed: () async {
                await FirebaseServices().googleSignOut();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Login_Signup()));
              },
              icon: Icon(Icons.logout_outlined, size: 30, color: Colors.black),
            ),
          ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: "Search Products",
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (query) {
                filterProducts(query);
              },
            ),
          ),
          Expanded(
            child: isLoading
                ? ShimmerList()
                : ListView.builder(
              itemCount: filteredData.isNotEmpty
                  ? filteredData.length
                  : data.length,
              itemBuilder: (context, index) {
                final product = filteredData.isNotEmpty
                    ? filteredData[index]
                    : data[index];

                return GestureDetector(
                  onTap: () {
                    final productProvider =
                    Provider.of<ProductProvider>(context, listen: false);
                    productProvider.selectProduct(product);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Product_Details(),
                      ),
                    );
                  },
                  child: ProductListItem(product: product),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage()),
          );
        },
        child: Icon(Icons.add_shopping_cart),
      ),
    );
  }
}



class ProductListItem extends StatelessWidget {
  final Product product;

  ProductListItem({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 20,
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
          Hero(
            tag: 'product_${product.id}',
            child: Container(
              width: 150,
              height: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  product.image,
                  fit: BoxFit.fill,
                ),
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
                    product.title,
                    style: const TextStyle(fontSize: 20
                        ,fontWeight: FontWeight.bold),
                  ),
                  Text(
                    product.category,
                    style: const TextStyle(fontSize: 15,
                        color: Colors.red),
                  ),
                  Text(
                    "Price: \$${product.price.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 15,
                        color: Colors.green),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Container(
              width: double.infinity,
              height: 200,
              margin: const EdgeInsets.only(
                bottom: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          );
        },
      ),
    );
  }
}