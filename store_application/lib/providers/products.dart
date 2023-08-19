import 'package:flutter/material.dart';
import 'package:store_application/providers/product.dart';

class Products with ChangeNotifier {
  List<Product> _item = [
    Product(
        id: 'p1',
        title: 'Red Shirt',
        description: 'A red shirt - this is pretty red',
        price: 29.99,
        imageUrl:
            'https://img.freepik.com/premium-photo/colorful-cotton-soft-clothes-hangers_580905-40.jpg?size=626&ext=jpg&ga=GA1.1.1389026622.1689521780&semt=ais'),
    Product(
        id: 'p2',
        title: 'Red Shirt',
        description: 'A red shirt - this is pretty red',
        price: 29.99,
        imageUrl:
            'https://img.freepik.com/free-photo/clothing-store_329181-8892.jpg?size=626&ext=jpg&ga=GA1.1.1389026622.1689521780&semt=ais'),
    Product(
        id: 'p3',
        title: 'Red Shirt',
        description: 'A red shirt - this is pretty red',
        price: 29.99,
        imageUrl:
            'https://img.freepik.com/free-photo/arrangement-father-son-clothing_23-2148868928.jpg?size=626&ext=jpg&ga=GA1.1.1389026622.1689521780&semt=ais'),
    Product(
        id: 'p4',
        title: 'Red Shirt',
        description: 'A red shirt - this is pretty red',
        price: 29.99,
        imageUrl:
            'https://img.freepik.com/premium-photo/blank-white-clothes-tag-new-shirt-store_293060-2659.jpg?size=626&ext=jpg&ga=GA1.1.1389026622.1689521780&semt=ais'),
  ];

  List<Product> get items {
    return [..._item];
  }

  void addProduct(Product p) {
    final newProduct = Product(
      title: p.title,
      description: p.description,
      price: p.price,
      imageUrl: p.imageUrl,
      id: DateTime.now().toString(),
    );
    _item.add(newProduct);

    notifyListeners();
  }
  // Future<void> addProduct(Product p) async {
  //   final url = Uri.https(
  //       'flutter-fifth-app-default-rtdb.firebaseio.com', '/products.json');

  //   try {
  //     final response = await http.post(
  //       url,
  //       body: json.encode(
  //         {
  //           'title': p.title,
  //           'description': p.description,
  //           'price': p.price,
  //           'imageUrl': p.imageUrl,
  //           'id': p.id,
  //           'isFavorit': p.isFavorit,
  //         },
  //       ),
  //     );

  //     final newProduct = Product(
  //       title: p.title,
  //       description: p.description,
  //       price: p.price,
  //       imageUrl: p.imageUrl,
  //       id: json.decode(response.body)['name'],
  //     );

  //     _item.add(newProduct);
  //     notifyListeners();
  //   } catch (error) {
  //     // Handle the error here
  //     print('Error adding product: $error');
  //   }
  // }

  void updateProduct(String id, Product editedProduct) {
    final index = _item.indexWhere((item) => item.id == id);
    if (index >= 0) {
      _item[index] = editedProduct;
      print(index);
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    _item.removeWhere((item) => item.id == id);
  }

  Product findById(String id) {
    return _item.firstWhere((element) => element.id == id);
  }

  List<Product> get favoritItems {
    return _item.where((i) => i.isFavorit).toList();
  }
}
