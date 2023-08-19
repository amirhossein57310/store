import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_application/providers/products.dart';
import 'package:store_application/widget/product_item.dart';

class ProductGrid extends StatelessWidget {
 final bool selected;
  const ProductGrid(this.selected,{
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final productItem = selected? productData.favoritItems :  productData.items;
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return ChangeNotifierProvider.value(
          value: productItem[index],
          child: const ProductItem(),
        );
      },
      itemCount: productItem.length,
    );
  }
}
