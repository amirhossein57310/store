import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_application/providers/cart.dart';

class BasketItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;
  const BasketItem(
      this.id, this.productId, this.price, this.quantity, this.title,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text(
                'Are you sure',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'rc',
                ),
              ),
              content: const Text(
                'Delete this Item',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'rc',
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(false);
                  },
                  child: const Text(
                    'No',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'rc',
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(true);
                  },
                  child: const Text(
                    'Yes',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'rc',
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      key: ValueKey(id),
      direction: DismissDirection.startToEnd,
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          size: 25,
        ),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: FittedBox(
                child: Text(
                  '\$$price',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'rc',
                  ),
                ),
              ),
            ),
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'rc',
              ),
            ),
            subtitle: Text(
              'Total : \$${quantity * price}',
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'rc',
              ),
            ),
            trailing: Text(
              '$quantity x',
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'rc',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
