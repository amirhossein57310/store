import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_application/providers/cart.dart';
import 'package:store_application/providers/orders.dart';
import 'package:store_application/widget/basket_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  static const routName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Total',
                      style: TextStyle(fontSize: 18, fontFamily: 'rc'),
                    ),
                    Spacer(),
                    Chip(
                      label: Text(
                        '\$${cart.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontFamily: 'rc',
                            fontSize: 20,
                            color: Theme.of(context)
                                .primaryTextTheme
                                .bodySmall!
                                .color),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Provider.of<Orders>(context, listen: false).addOrder(
                            cart.items.values.toList(), cart.totalAmount);
                        cart.cleanItem();
                      },
                      child: Text(
                        'Order Now',
                        style: TextStyle(
                            fontFamily: 'rc',
                            fontSize: 20,
                            color: Theme.of(context)
                                .primaryTextTheme
                                .bodySmall!
                                .color),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) => BasketItem(
                cart.items.values.toList()[index].id,
                cart.items.keys.toList()[index],
                cart.items.values.toList()[index].price,
                cart.items.values.toList()[index].quantity,
                cart.items.values.toList()[index].title,
              ),
            ))
          ],
        ),
      ),
    );
  }
}
