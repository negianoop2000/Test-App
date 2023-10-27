import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newapp/cart_provider.dart';
import 'package:newapp/signup.dart';
import 'package:newapp/product_list.dart';
import 'package:newapp/product_model.dart';
import 'package:newapp/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  await Hive.openBox<Product>('products');
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ProductProvider()),
          ChangeNotifierProvider(create: (_) => CartProvider()), // Add the CartProvider
        ],
        child: MyApp(),
      )
  );

}


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      home: Product_List(),
    );
  }
}


