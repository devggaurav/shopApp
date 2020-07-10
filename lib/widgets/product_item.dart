import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:shopapp/providers/auth.dart';
import 'package:shopapp/providers/cart.dart';
import 'package:shopapp/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/models/product.dart';

class ProductItem extends StatelessWidget {
  /* final String id;
  final String title;
  final String imageUrl;*/

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    // final product = Provider.of<Product>(context); alternat will be consumer

    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context,listen: false);
    final authData = Provider.of<Auth>(context,listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            // Navigator.of(context).push(
            //     MaterialPageRoute(builder: (ctx) => ProductDetailScreen(title)));//on the fly
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          //another way of listening
          leading: Consumer<Product>( // using consumer to listen when listen is false in provider
            builder: (ctx, product, child) => IconButton(
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),

              onPressed: () {
                product.toggelFavoriteStatus(authData.token,authData.userId);
              },

              color: Theme.of(context).accentColor,
            ),

          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
              //Scaffold.of(context).openDrawer(); //can open drawer
                Scaffold.of(context).hideCurrentSnackBar();
                Scaffold.of(context).showSnackBar(SnackBar(content: Text('Added item to cart!'),
                duration: Duration(seconds: 2),action: SnackBarAction(label: 'UNDO',onPressed: (){
                  cart.removeSingleItem(product.id);
                  
                  },),));
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
