import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_application/providers/cart.dart';
import 'package:store_application/screen/cart_screen.dart';
import 'package:store_application/widget/app_drawer.dart';
import 'package:store_application/widget/badge.dart';

import '../widget/product_grid.dart';

class ProductOverviewScreen extends StatefulWidget {
  ProductOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

enum FilterOptions {
  Favorit,
  All,
}

bool _isSelected = false;

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorit) {
                  _isSelected = true;
                } else {
                  _isSelected = false;
                }
              });
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: FilterOptions.Favorit,
                  child: Text('Only Favorits'),
                ),
                const PopupMenuItem(
                  value: FilterOptions.All,
                  child: Text('Show All'),
                ),
              ];
            },
          ),
          Consumer<Cart>(
            builder: (context, value, ch) => BadgeWidget(
              ch!,
              value.itemCount.toString(),
              Theme.of(context).primaryColor,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routName);
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
        ],
        title: const Text('my shop'),
      ),
      body: SafeArea(
        child: ProductGrid(_isSelected),
      ),
    );
  }
}
