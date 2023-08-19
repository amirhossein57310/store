import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_application/providers/product.dart';
import 'package:store_application/providers/products.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);
  static const routeName = '/edit-product';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  var _editedProduct =
      Product(id: '', title: '', description: '', price: 0, imageUrl: '');

  var _initialValues = {
    'id': '',
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': ''
  };
  bool start = false;

  @override
  void didChangeDependencies() {
    final productId = ModalRoute.of(context)!.settings.arguments as String?;
    if (productId == null) {
      return;
    } else {
      _editedProduct = Provider.of<Products>(context, listen: false)
          .findById(productId.toString());
      _initialValues = {
        'id': _editedProduct.id,
        'title': _editedProduct.title,
        'description': _editedProduct.description,
        'price': _editedProduct.price.toString(),
        'imageUrl': '',
      };
      _imageUrlController.text = _editedProduct.imageUrl;
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlController.removeListener(_updateImageUrl);

    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _imageUrlController.addListener(() {
      _updateImageUrl();
    });

    super.initState();
  }

  void _updateImageUrl() {
    if (_imageUrlFocusNode.hasFocus) {
      var iu = _imageUrlController.text;
      if (!iu.startsWith('https') && !iu.startsWith('http')) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    final productId = ModalRoute.of(context)!.settings.arguments;
    var isValidate = _formKey.currentState!.validate();
    if (!isValidate) {
      return;
    }
    _formKey.currentState!.save();
    if (productId == null) {
      Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    } else {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: const Icon(Icons.save),
          ),
        ],
        title: const Text(
          'Edit product',
          style: TextStyle(
            fontFamily: 'rc',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  initialValue: _initialValues['title'].toString(),
                  style: const TextStyle(
                    fontFamily: 'rc',
                    fontWeight: FontWeight.bold,
                  ),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Please enter the product name';
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    labelStyle: TextStyle(
                      fontFamily: 'rc',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  onSaved: (v) {
                    _editedProduct = Product(
                      id: _editedProduct.id,
                      title: v!,
                      description: _editedProduct.description,
                      price: _editedProduct.price,
                      imageUrl: _editedProduct.imageUrl,
                    );
                  },
                ),
                TextFormField(
                  initialValue: _initialValues['price'].toString(),
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    labelStyle: TextStyle(
                      fontFamily: 'rc',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  focusNode: _priceFocusNode,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  onSaved: (v) {
                    _editedProduct = Product(
                      id: _editedProduct.id,
                      title: _editedProduct.title,
                      description: _editedProduct.description,
                      price: double.parse(v!),
                      imageUrl: _editedProduct.imageUrl,
                    );
                  },
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Please enter a price';
                    }
                    if (double.tryParse(v) == null) {
                      return 'Please enter a valid price';
                    }
                    if (double.parse(v) <= 0) {
                      return 'Please enter a number geater than zero';
                    }
                  },
                ),
                TextFormField(
                  initialValue: _initialValues['description'].toString(),
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(
                      fontFamily: 'rc',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  focusNode: _descriptionFocusNode,
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  onSaved: (v) {
                    _editedProduct = Product(
                      id: _editedProduct.id,
                      title: _editedProduct.title,
                      description: v!,
                      price: _editedProduct.price,
                      imageUrl: _editedProduct.imageUrl,
                    );
                  },
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Please enter a description';
                    }
                    if (v.length < 11) {
                      return 'Please explain more about your product';
                    }
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      margin: const EdgeInsets.only(right: 10, top: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: _imageUrlController.text.isEmpty
                          ? const Center(
                              child: Text(
                                'Enter Url',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'rc',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Image.network(
                                  _imageUrlController.text,
                                ),
                              ),
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'ImageUrl',
                          labelStyle: TextStyle(
                            fontFamily: 'rc',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        controller: _imageUrlController,
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        focusNode: _imageUrlFocusNode,
                        onSaved: (v) {
                          _editedProduct = Product(
                            id: _editedProduct.id,
                            title: _editedProduct.title,
                            description: _editedProduct.description,
                            price: _editedProduct.price,
                            imageUrl: v!,
                          );
                        },
                        onFieldSubmitted: (value) => _saveForm(),
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Enter a URL';
                          }
                          if (!v.startsWith('https') && !v.startsWith('http')) {
                            return 'Invalid URL';
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
