import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_application/providers/orders.dart';
import 'package:store_application/widget/app_drawer.dart';
import 'package:store_application/widget/order_basket.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  static const routeName = 'orders';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Your Order'),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: orderData.orders.length,
          itemBuilder: (context, index) {
            return OrderBasket(orderData.orders[index]);
          },
        ),
      ),
    );
  }
}
