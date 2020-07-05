import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/orders.dart' show Orders;
import 'package:shopapp/widgets/app_drawer.dart';
import 'package:shopapp/widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

 /* @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;

  @override
  void initState() {
    *//* Future.delayed(Duration.zero).then((_) async{
        setState(() {
          _isLoading = true;
        });

      await Provider.of<Orders>(context,listen: false).fetchAndSetOrders();

       setState(() {
         _isLoading = false;
       });

     });*//*

    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    //final ordersData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Orders'),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
            future:
                Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
            builder: (ctx, dataSnaShot) {
              if (dataSnaShot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (dataSnaShot.error != null) {
                  return Center(
                    child: Text('An error occured'),
                  );
                } else {
                  return Consumer<Orders>(
                      builder: (ctx, ordersData, chile) => ListView.builder(
                            itemCount: ordersData.orders.length,
                            itemBuilder: (ctx, i) =>
                                OrderItem(ordersData.orders[i]),
                          ),
                  );
                }
              }
            }));
  }
}
