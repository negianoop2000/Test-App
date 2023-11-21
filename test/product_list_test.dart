import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:newapp/product_list.dart';
import 'package:path_provider/path_provider.dart';
import 'setup.dart';


void main() {
  setUpAll(() async {
    // Initialize Hive for testing
    await setupHiveForTesting();
  });

  tearDownAll(() async {
    // Close Hive after all tests have finished
    await closeHiveForTesting();
  });

  group('Product List Page Tests', () {
    testWidgets('Test if the product list page loads correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Product_List()));

      expect(find.text('Product List'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(ProductListItem), findsWidgets);
    });

    testWidgets('Test if data is loaded and displayed correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Product_List()));

      await tester.pumpAndSettle();

      expect(find.byType(ProductListItem), findsWidgets);
      // You can add more assertions to check specific data if needed
    });
  });
}
