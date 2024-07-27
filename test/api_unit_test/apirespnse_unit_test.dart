
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:newapp/product_model.dart';

import 'product_repo.dart';


class MockHTTPClient extends Mock implements Client {}

void main() {
  late Product_Repo prodeuctrep;
  late MockHTTPClient mockHTTPClient;

  setUp(() {
    mockHTTPClient = MockHTTPClient();
    prodeuctrep = Product_Repo(mockHTTPClient);
  });

  group('Product Repo - ', () {
    group('getproduct function', () {
      test(
        'given ProductRepository class when getProduct function is called and status code is 200 then a Product model should be returned',
            () async {
          // Arrange
          when(() => mockHTTPClient.get(
            Uri.parse('https://fakestoreapi.com/products/1'),
          )).thenAnswer((invocation) async {
            return Response(
                json.encode({
                  "id": 1,
                  "title": "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
                  "price": 109.95,
                  "description": "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
                  "category": "men's clothing",
                  "image":
                  "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
                  "rating": {"rate": 3.9, "count": 120}
                }),
                200);
          });

          // Act
          final product = await prodeuctrep.getProduct();

          // Assert
          expect(product, isA<Product>());
        },
      );


      test(
        'fetching a product from the product list',
            () async {
          // arrange
          when(
                () => mockHTTPClient.get(
              Uri.parse('https://fakestoreapi.com/products/1'),
            ),
          ).thenAnswer((invocation) async => Response('{}', 500));
          // act
          final product = prodeuctrep.getProduct();
          // assert
          expect(product, throwsException);
        },
      );
    });
  });
}