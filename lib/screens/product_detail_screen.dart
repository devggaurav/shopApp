import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  /* final String title;

    ProductDetailScreen(this.title);*/

  static const routeName = 'ProductDetail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    // final loadedProduct = Provider.of<Products>(context).items.firstWhere((element) => element.id == productId); one Way

    final loadedProduct = Provider.of<Products>(context,listen: false).findById(productId); // it will not rebuild if set listen = false

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
    );
  }
}
