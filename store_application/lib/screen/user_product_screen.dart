import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_application/providers/products.dart';
import 'package:store_application/screen/edit_product_screen.dart';
import 'package:store_application/widget/app_drawer.dart';
import 'package:store_application/widget/user_product_item.dart';

class UserProductScreen extends StatelessWidget {
  const UserProductScreen({Key? key}) : super(key: key);

  static const routeName = '/user-product';
  @override
  Widget build(BuildContext context) {
    final userProduct = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: userProduct.items.length,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              UserProductItem(
                  userProduct.items[index].id,
                  userProduct.items[index].title,
                  userProduct.items[index].imageUrl),
            ],
          );
        },
      ),
    );
  }
}
