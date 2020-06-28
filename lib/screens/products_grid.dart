import 'package:flutter/material.dart';
import 'package:shopapp/providers/products.dart';
import '../models/product.dart';
import '../widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {

   final bool showFavs;

    ProductsGrid(this.showFavs);



  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final products = showFavs ? productData.favoriteItems : productData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) => /*ChangeNotifierProvider(
        builder: (c) => products[i],*/
      ChangeNotifierProvider.value(value: products[i],  // we should use ChangeNotifierProvider.value in case of large list , bcz of recycle behaviour of widgets.
        child: ProductItem(
           // products[i].id, products[i].title, products[i].imageUrl
        ),
      ),
    );
  }
}
