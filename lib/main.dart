import 'package:flutter/material.dart';
import 'package:shopapp/screens/product_detail_screen.dart';
import 'package:shopapp/screens/products_overview_screen.dart';
import 'package:provider/provider.dart';
import './providers/products.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
       builder: (ctx) => Products(),// use 'create' instead of builder for version 4.0.0 of provider.

      //alternative of builder
      /* return ChangeNotifierProvider.value{
                   value : Products(),

      *
      *
      * */

      child: MaterialApp(
        title: 'My Shop App',
        theme: ThemeData(

          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ProductsOverviewScreen(),
        routes: {ProductDetailScreen.routeName: (ctx) => ProductDetailScreen()},
      ),
    );
  }
}




