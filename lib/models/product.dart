import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavorite = false});

  void _setFavValue(bool status){
      isFavorite = status;
      notifyListeners();
  }

 /*
   //For all users
 Future<void> toggelFavoriteStatus(String token) async{
     final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
     final url = 'https://myflutterapp-1e3db.firebaseio.com/products/$id.json?auth=$token';
      try {
      final response = await http.patch(url, body: json.encode({
          'isFavorite': isFavorite,
        }),

      );
      if(response.statusCode >= 400){
        _setFavValue(oldStatus);

      }

      }catch(error){
        _setFavValue(oldStatus);

      }

  }*/

 //For single user
  Future<void> toggelFavoriteStatus(String token,String userId) async{
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url = 'https://myflutterapp-1e3db.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';
    try {
      final response = await http.put(url, body: json.encode(
        isFavorite,
      ),

      );
      if(response.statusCode >= 400){
        _setFavValue(oldStatus);

      }

    }catch(error){
      _setFavValue(oldStatus);

    }

  }


}
