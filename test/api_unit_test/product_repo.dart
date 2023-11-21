import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newapp/product_model.dart';

class Product_Repo {
  final http.Client client;
  Product_Repo(this.client);

  Future<Product> getProduct() async {
    final response = await client.get(
      Uri.parse('https://fakestoreapi.com/products/1'),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return Product.fromJson(jsonData);
    }
    throw Exception('Some Error Occurred');
  }
}
