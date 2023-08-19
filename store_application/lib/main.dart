import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_application/providers/cart.dart';
import 'package:store_application/providers/orders.dart';
import 'package:store_application/providers/products.dart';
import 'package:store_application/screen/cart_screen.dart';
import 'package:store_application/screen/edit_product_screen.dart';
import 'package:store_application/screen/order_screen.dart';
import 'package:store_application/screen/product_detail_screen.dart';
import 'package:store_application/screen/product_overview_screen.dart';
import 'package:store_application/screen/user_product_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          secondaryHeaderColor: Colors.pink,
          primaryColor: Colors.blueAccent,
          fontFamily: 'rw',
        ),
        home: ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) =>
              const ProductDetailScreen(),
          CartScreen.routName: (context) => const CartScreen(),
          OrderScreen.routeName: (context) => const OrderScreen(),
          UserProductScreen.routeName: (context) => const UserProductScreen(),
          EditProductScreen.routeName: (context) => const EditProductScreen(),
        },
      ),
    );
  }
}
