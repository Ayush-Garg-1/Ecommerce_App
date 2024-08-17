import 'dart:async';
import 'dart:io';
import 'package:ecommerce/models/cart_model.dart';
import '../models/products_model.dart';
import '../models/user_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  final String _dbFileName ="ecommerce_app";
  final String productTableName = "products";
  final String userTableName = "users";
  final String cartTableName = "cartProduct";
  Database? _db;

  Future createDbPath() async {
    final String _databaseFilePath;
    Directory _databasePath = await getApplicationDocumentsDirectory();
    _databaseFilePath = join(_databasePath.path, _dbFileName);
    return _databaseFilePath;
  }
  Future getDataBaseFile() async {
    final File _file = File(await createDbPath());
    return _file.path;
  }
  initializeDatabase() async {
    return await openDatabase(
      await getDataBaseFile(),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE $productTableName(id INTEGER PRIMARY KEY,title TEXT,description TEXT, category TEXT, price REAL, discountPercentage REAL,rating REAL, stock INTEGER, brand TEXT,warrantyInformation TEXT, returnPolicy TEXT,thumbnail TEXT)"
        );
        await db.execute("CREATE TABLE $userTableName(id INTEGER PRIMARY KEY AUTOINCREMENT,image TEXT,name TEXT,email TEXT,phone TEXT,password TEXT)");
        await db.execute("CREATE TABLE $cartTableName(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,price REAL,quantity INTEGER,images TEXT)");
      },
    );
  }

  Future<Database> get getDatabase async {
    if (_db != null) return _db!;
    _db = await initializeDatabase();
    return _db!;
  }

  Future insertProducts(List<ProductModel> products) async {
    try{
      Database dbClient = await getDatabase;
      dbClient.delete(productTableName);
      products.forEach((product){
        dbClient.insert(productTableName, product.toJson(product));
      });
    }catch(e){
      print("Insert Products Error : "+e.toString());
    }
  }

  Future<List<ProductModel>> getProducts() async {
    try {
      Database dbClient = await getDatabase;
      List<Map<String, dynamic>> productsInMap = await dbClient.query(
          productTableName);

      if (productsInMap.isEmpty) {
        print("No Users found in the database.");
        return [];
      }

      List<ProductModel> products = [];
      for (var productMap in productsInMap) {
        try {
          ProductModel product = ProductModel.fromJson(productMap);
          products.add(product);
        } catch (e) {
          print("Error in fetching getUserData: $e");
        }
      }

      return products;
    } catch (e) {
      print("Error in getUsersData: $e");
      return [];
    }
  }


  Future getProductsBasedOnSearch(String value) async{
    try{
      Database dbClient = await getDatabase;
      List<Map<String,dynamic>> productsMap=[];
      productsMap = await dbClient.rawQuery("SELECT * FROM $productTableName WHERE title LIKE '%$value%'",);
      List<ProductModel> priceWiseProducts = [];
      for (var productMap in productsMap) {
        try {
          ProductModel product = ProductModel.fromJson(productMap);
          priceWiseProducts.add(product);
        } catch (e) {
          print("Error processing product: $e");
        }
      }
      return priceWiseProducts;
    }catch(e){
      print(e.toString());
      return [];
    }
  }


  Future getProductBasedOnFilter(String value) async{
    print(value);
    try{
      Database dbClient = await getDatabase;
      List<Map<String,dynamic>> productsMap=[];
      switch(value) {
        case 'PRICE(LOWEST)':
          productsMap =
          await dbClient.rawQuery("SELECT * FROM $productTableName ORDER BY price");
          break;
        case 'PRICE(HIGHEST)':
          productsMap =
          await dbClient.rawQuery("SELECT * FROM $productTableName ORDER BY price DESC");
          break;
        case 'A TO Z':
          productsMap =
          await dbClient.rawQuery("SELECT * FROM $productTableName ORDER BY title");
          break;
        case 'Z TO A':
          productsMap =
          await dbClient.rawQuery("SELECT * FROM $productTableName ORDER BY title DESC");
          break;
        default:
          productsMap = await dbClient.rawQuery("SELECT * FROM $productTableName");
      }

      List<ProductModel> filterWiseProducts = [];
      for (var productMap in productsMap) {
        try {
          ProductModel product = ProductModel.fromJson(productMap);
          filterWiseProducts.add(product);
        } catch (e) {
          print("Error processing product: $e");
        }
      }

      return filterWiseProducts;
    }catch(e){
      print(e.toString());
      return [];
    }
  }


  Future getProductBasedOnPriceRange(int price1,int price2) async{
    try{
      Database dbClient = await getDatabase;
      List<Map<String,dynamic>> productsMap=[];
      productsMap = await dbClient.rawQuery
        ("SELECT * FROM $productTableName WHERE price >= $price1 AND price <= $price2");
      List<ProductModel> priceWiseProducts = [];
      for (var productMap in productsMap) {
        try {
          ProductModel product = ProductModel.fromJson(productMap);
          priceWiseProducts.add(product);
        } catch (e) {
          print("Error processing product: $e");
        }
      }

      return priceWiseProducts;
    }catch(e){
      print(e.toString());
      return [];
    }
  }


  Future getProductsCategories() async{
    try{
      Database dbClient = await getDatabase;
      List<Map<String, dynamic>> categories = await
      dbClient.rawQuery
        ("SELECT DISTINCT category FROM $productTableName");
      List<String> productsCategories = [];
      categories.forEach((category){
        productsCategories.add(category["category"]);
      });
      productsCategories.insert(0,"all");
      return productsCategories;
    }catch(e){
      print(e.toString());
      return [];
    }
  }


  Future<List<ProductModel>> getCategoryWiseProducts(String category,bool limit) async{
    print(category);
    try{
      Database dbClient = await getDatabase;
      List<Map<String,dynamic>> productsMap=[];
      List<ProductModel> categoriesWiseProducts = [];
        if (category == "all") {
          categoriesWiseProducts=[];
          productsMap = await dbClient.rawQuery("SELECT * FROM $productTableName");
          for (var productMap in productsMap) {
            try {
              ProductModel product = ProductModel.fromJson(productMap);
              categoriesWiseProducts.add(product);
            } catch (e) {
              print("Error processing product: $e");
            }
          }
        }
        else {
          categoriesWiseProducts=[];
          if(limit== true){
            productsMap = await dbClient.rawQuery("SELECT * FROM $productTableName WHERE category=? LIMIT 4",[category]);
          }
          else{
            productsMap = await dbClient.rawQuery("SELECT * FROM $productTableName WHERE category=?",[category]);
          }
          for (var productMap in productsMap) {
            print(productMap);
            try {
              ProductModel product = ProductModel.fromJson(productMap);
              categoriesWiseProducts.add(product);
            } catch (e) {
              print("Error processing product: $e");
            }
          }
        }
      return categoriesWiseProducts;
    }catch(e){
      print(e.toString());
      return [];
    }
  }










  //  Cart Table

  Future insertCartProduct(ProductModel product) async{
    try{
      Database dbClient = await getDatabase;
      Map<String,dynamic> data={
        'id': product.id,
  'title': product.title,
  'price': product.price,
  'quantity':1,
  'images': product.thumbnail,
      };
      await dbClient.insert(cartTableName, data);
    }catch(e){
      print("Insert cart product Error : "+e.toString());
    }
}



Future<List<CartProductModel>> getCartProducts() async {
    try {
      Database dbClient = await getDatabase;
      List<Map<String, dynamic>> usersInMap = await dbClient.query(
          cartTableName);

      if (usersInMap.isEmpty) {
        print("No Users found in the database.");
        return [];
      }
      List<CartProductModel> products = [];
      for (var userMap in usersInMap) {
        try {
          CartProductModel product = CartProductModel.fromJson(userMap);
          products.add(product);
        } catch (e) {
          print("Error in fetching getProductData: $e");
        }
      }
      return products;
    } catch (e) {
      print("Error in getProductData: $e");
      return [];
    }
  }



  Future increaseProductQuentity(int id) async {
    try {
      Database dbClient = await getDatabase;
      await dbClient.rawUpdate(
        'UPDATE $cartTableName SET quantity = quantity + ? WHERE id = ?',
        [1, id],
      );
    } catch (e) {
      print("Error in Quentity: $e");
    }
  }




  Future decreaseProductQuentity(int id) async {
    try {
      Database dbClient = await getDatabase;
      await dbClient.rawUpdate(
        'UPDATE $cartTableName SET quantity = quantity - ? WHERE id = ?',
        [1, id],
      );
    } catch (e) {
      print("Error in Quentity: $e");
    }
  }



  Future deletecartProduct(int id) async {
    try {
      Database dbClient = await getDatabase;
      await dbClient.rawDelete(
        'DELETE FROM $cartTableName WHERE id = ?',
        [id],
      );
    } catch (e) {
      print("Error deleting product: $e");
    }
  }




  // User Table Code

  Future insertUser(Map<String,dynamic> user) async {
    try{
      Database dbClient = await getDatabase;
      var users = await dbClient.rawQuery("SELECT * FROM $userTableName WHERE email=?",[user["email"]]);
      if(users.length > 0){
        return 300;
      }else{
        dbClient.insert(userTableName, user);
        return 200;
      }
    }catch(e){
      print("Insert user Error : "+e.toString());
      return 400;
    }
  }

  Future checkUserLogin(String email,String password)async{
    try{
      Database dbClient = await getDatabase;
      List<Map<String, Object?>> users = await dbClient.rawQuery("SELECT * FROM $userTableName WHERE email=? AND password=?",[email,password]);
      if(users.length >0){
        return 200;
      }else {
        return 300;
      }
    }catch(e){
      print("Error In User Login Check $e");
      return 400;
    }
  }


  Future<List<UsersModel>> getUsersData() async {
    try {
      Database dbClient = await getDatabase;
      List<Map<String, dynamic>> usersInMap = await dbClient.query(
          productTableName);

      if (usersInMap.isEmpty) {
        print("No Users found in the database.");
        return [];
      }

      List<UsersModel> users = [];
      for (var userMap in usersInMap) {
        try {
          UsersModel user = UsersModel.fromJson(userMap);
          users.add(user);
        } catch (e) {
          print("Error in fetching getUserData: $e");
        }
      }

      return users;
    } catch (e) {
      print("Error in getUsersData: $e");
      return [];
    }
  }



  Future setUserImage(String image,String email) async{
    try{
      Database dbClient = await getDatabase;
      await dbClient.rawUpdate(
        'UPDATE $userTableName SET image = ? WHERE email = ?',
        [image, email],
      );
    }catch(e){
      print("Error in set image : "+e.toString());
    }
  }

  Future<UsersModel> getLoginUserInfo(String email) async{

    Database dbClient = await getDatabase;
    List<Map<String, dynamic>> mapUser = await dbClient.rawQuery("SELECT * FROM $userTableName WHERE email=?",[email]) ;
    UsersModel user = UsersModel.fromJson(mapUser[0]);
    return user;
  }

}