import 'package:flutter/material.dart';
import 'package:shopapp/models/http_exception.dart';
import '../models/product.dart';
import 'dart:convert'; //for json conversition
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [
    /*Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),*/
  ];

  final String authToken;
  final String userId;

  Products(this.authToken,this.userId,this._items);

  var _showFavoritesOnly = false;

  List<Product> get items {
    /* if(_showFavoritesOnly) {
      return _items.where((element) => element.isFavorite).toList();
     }*/
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  /* void showFavOnly(){
     _showFavoritesOnly = true;
     notifyListeners();
   }

   void showAll(){
     _showFavoritesOnly = false;
     notifyListeners();
   }*/

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  /*Future<void> addProduct(Product product) {
     const url = 'https://myflutterapp-1e3db.firebaseio.com/products.json';
     return http.post(url,body: json.encode({
       'title':product.title,
       'description':product.description,
       'imageUrl':product.imageUrl,
       'price':product.price,
       'isFavorite':product.isFavorite
     }),).then((value){
       print(json.decode(value.body));
       final newProduct = Product(
           title: product.title,
           description: product.description,
           price: product.price,
           imageUrl: product.imageUrl,
           id: json.decode(value.body)['name'],);

       _items.add(newProduct);

       notifyListeners();


     }).catchError((error){
        print(error);
        throw error;
     });
  }*/

 /*
  // with favorites for all
 Future<void> addProduct(Product product) async {
    final url = 'https://myflutterapp-1e3db.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite
        }),
      );

      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );

      _items.add(newProduct);

      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }*/


  Future<void> addProduct(Product product) async {
    final url = 'https://myflutterapp-1e3db.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'creatorId': userId, // adding product according to user

        }),
      );

      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );

      _items.add(newProduct);

      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }





 /*
  Getting fav status for all
 Future<void> fetchAndSetProducts() async {
    final url = 'https://myflutterapp-1e3db.firebaseio.com/products.json?auth=$authToken';

    try {
      final response = await http.get(url);
      final extractData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProduct = [];
      extractData.forEach((prodId, prodData) {
        loadedProduct.add(Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            imageUrl: prodData['imageUrl'],
            isFavorite: prodData['isFavorite']));
      });
      _items = loadedProduct;
      notifyListeners();
      print(json.decode(response.body));
    } catch (error) {
      throw (error);
    }
  }*/

  /* void updateProduct(String id, Product newProduct) {
    final proIndex = _items.indexWhere((element) => element.id == id);
    if (proIndex >= 0) {

      _items[proIndex] = newProduct;
      notifyListeners();
    } else {
      print(".....");
    }
  }*/


  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {

     final filterString = filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';

    var url = 'https://myflutterapp-1e3db.firebaseio.com/products.json?auth=$authToken&$filterString';

    try {
      final response = await http.get(url);
      final extractData = json.decode(response.body) as Map<String, dynamic>;
       if(extractData == null){
         return;
       }
        url = 'https://myflutterapp-1e3db.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
       final favoriteResponse = await http.get(url);

        final favoriteData = json.decode(favoriteResponse.body);

      final List<Product> loadedProduct = [];
      extractData.forEach((prodId, prodData) {
        loadedProduct.add(Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            imageUrl: prodData['imageUrl'],
            isFavorite: favoriteData == null ? false : favoriteData[prodId] ?? false));
      });
      _items = loadedProduct;
      notifyListeners();
      print(json.decode(response.body));
    } catch (error) {
      throw (error);
    }
  }




  void updateProduct(String id, Product newProduct) async {
    final proIndex = _items.indexWhere((element) => element.id == id);
    if (proIndex >= 0) {
      final url = 'https://myflutterapp-1e3db.firebaseio.com/products/$id.json?auth=$authToken';
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price
          }));
      _items[proIndex] = newProduct;
      notifyListeners();
    } else {
      print(".....");
    }
  }

  /*void deleteProduct(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }*/

  /*void deleteProduct(String id) {
    final url = 'https://myflutterapp-1e3db.firebaseio.com/products/$id.json';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();

    // _items.removeWhere((element) => element.id == id);
    http.delete(url).then((response) {
      if (response.statusCode >= 400) {
        throw HttpException('Could not delete product.');
      }

      existingProduct = null;
    }).catchError((_) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
    });
  }*/

  Future<void> deleteProduct(String id) async {
    final url = 'https://myflutterapp-1e3db.firebaseio.com/products/$id.json?auth=$authToken';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];

    _items.removeAt(existingProductIndex);
    notifyListeners();
    // _items.removeWhere((element) => element.id == id);
    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
  }
}
