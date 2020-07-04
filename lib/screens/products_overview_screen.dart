import 'package:flutter/material.dart';
import 'package:shopapp/models/product.dart';
import 'package:shopapp/providers/cart.dart';
import 'package:shopapp/providers/products.dart';
import 'package:shopapp/screens/cart_screen.dart';
import 'package:shopapp/screens/products_grid.dart';
import 'package:shopapp/widgets/app_drawer.dart';
import 'package:shopapp/widgets/badge.dart';
import 'package:shopapp/widgets/product_item.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavourite = false;
  var _isInit = true;
  var _isLoading = false;


  @override
  void initState() {
    // Provider.of<Products>(context).fetchAndSetProducts(); this won't work

     /*Future.delayed(Duration.zero).then((_){ // this will work but its an hack
       Provider.of<Products>(context).fetchAndSetProducts();
     });*/
    
    super.initState();
  }

  @override
  void didChangeDependencies() {
        if(_isInit){
          setState(() {
            _isLoading = true;
          });

          Provider.of<Products>(context).fetchAndSetProducts().then((_){
            setState(() {
              _isLoading = false;
            });

          } );

        }
        _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //  final productContainer = Provider.of<Products>(context,listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (FilterOptions selected) {
              setState(() {
                if (selected == FilterOptions.Favorites) {
                  _showOnlyFavourite = true;
                } else {
                  _showOnlyFavourite = false;
                }
                ;
              });
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
          ),
          Consumer<Cart>(
            builder: (_, cartData, ch) =>
                Badge(child: ch, value: cartData.itemCount.toString()),
            child: IconButton(
              icon: Icon(Icons.shopping_cart,),
              onPressed: (){
                 Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading ? Center(child: CircularProgressIndicator(),) : ProductsGrid(_showOnlyFavourite),
    );
  }
}
