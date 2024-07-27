import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:newapp/product_list.dart';
import 'package:http/http.dart' as http;
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:newapp/product_provider.dart';



void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Product List screen test', (tester) async {


    await tester.pumpWidget(
         MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ProductProvider()),
          ],
          child: MaterialApp(home: Product_List()),
        ),
    );

    await tester.pumpAndSettle();
    expect(find.text("Product List"), findsOneWidget);


    await tester.tap(find.text("Mens Casual Premium Slim Fit T-Shirts "));


    await tester.pumpAndSettle();
    expect(find.text("Product Detail"), findsOneWidget);
    expect(find.text("Buy"), findsOneWidget);


    await tester.tap(find.text("Buy"));
   await tester.pumpAndSettle();

    await tester.pumpAndSettle(const Duration(seconds: 5));
 //  expect(find.text("Add to Cart"), findsOneWidget);

//    await tester.tap(find.text("Buy"));
    expect(find.text('Continue'), findsOneWidget);



  });
}
