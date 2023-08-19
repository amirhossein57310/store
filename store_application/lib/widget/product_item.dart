import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_application/providers/cart.dart';
import 'package:store_application/providers/product.dart';
import 'package:store_application/screen/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          title: Text(
            product.title,
            overflow: TextOverflow.visible,
          ),
          trailing: IconButton(
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    'Added Item to cart',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  duration: const Duration(
                    seconds: 3,
                  ),
                  action: SnackBarAction(
                    label: 'Undo',
                    textColor: Colors.white,
                    onPressed: () => cart.removeLastItem(product.id),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.shopping_cart),
            color: Theme.of(context).secondaryHeaderColor,
          ),
          leading: Consumer<Product>(
            builder: (context, value, child) {
              return IconButton(
                icon: Icon(
                    product.isFavorit ? Icons.favorite : Icons.favorite_border),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  product.toggleFavorit();
                },
              );
            },
          ),
          backgroundColor: Colors.black54,
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                arguments: product.id);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
