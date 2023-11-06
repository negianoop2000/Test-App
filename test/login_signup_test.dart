import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:newapp/product_list.dart';
import 'package:newapp/signup.dart';

void main() {
  setUpAll(() async {

    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  });

  testWidgets('Test Login_Signup widget', (WidgetTester tester) async {
    // Build the Login_Signup widget
    await tester.pumpWidget(MaterialApp(home: Login_Signup()));

    // Verify that the widget is displayed
    expect(find.byType(Login_Signup), findsOneWidget);

    // Verify the presence of key widgets and interactions
    expect(find.text("Continue with Google"), findsOneWidget);
    expect(find.text("Throw Test Exception"), findsOneWidget);

    // Simulate a tap on the "Continue with Google" button
    await tester.tap(find.text("Continue with Google"));
    await tester.pump();

    // Verify that we have navigated to the Product_List screen
    expect(find.byType(Product_List), findsOneWidget);

    // Ensure that the "Throw Test Exception" button crashes the app
    expect(() => tester.tap(find.text("Throw Test Exception")), throwsException);
  });
}
