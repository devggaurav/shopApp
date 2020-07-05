import 'package:flutter/material.dart';
import 'package:shopapp/providers/cart.dart';
import 'package:shopapp/screens/auth_screen.dart';
import 'package:shopapp/screens/cart_screen.dart';
import 'package:shopapp/screens/edit_product_screen.dart';
import 'package:shopapp/screens/orders_screen.dart';
import 'package:shopapp/screens/product_detail_screen.dart';
import 'package:shopapp/screens/products_overview_screen.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/screens/user_products_screen.dart';
import './providers/products.dart';
import 'providers/orders.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          // use 'create' instead of builder for version 4.0.0 of provider.
         // value: Products(),
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          // use 'create' instead of builder for version 4.0.0 of provider.
          //value: Cart(),
            create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          // use 'create' instead of builder for version 4.0.0 of provider.
         // value: Orders(),
          create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
        title: 'My Shop App',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        //home: ProductsOverviewScreen(),
        home: AuthScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
        },
      ),
    );
  }
}
