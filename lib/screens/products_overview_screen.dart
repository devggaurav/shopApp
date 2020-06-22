import 'package:flutter/material.dart';
import 'package:shopapp/models/product.dart';
import 'package:shopapp/providers/products.dart';
import 'package:shopapp/screens/products_grid.dart';
import 'package:shopapp/widgets/product_item.dart';
import 'package:provider/provider.dart';
enum FilterOptions{
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final productContainer = Provider.of<Products>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (FilterOptions selected) {
             if(selected == FilterOptions.Favorites){
                 productContainer.showFavOnly();
             }else{
               productContainer.showAll();
             };
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          )
        ],
      ),
      body: ProductsGrid(),
    );
  }
}
