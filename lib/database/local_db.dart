import 'package:ecommerce/model/product.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  Future<Database> openDB() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    var database = await openDatabase(path, version: 1, onCreate: (db, version) async {
      // When creating the db, create the table
      await db
          .execute('CREATE TABLE ProductDetails(id INTEGER  PRIMARY KEY, slug TEXT, title TEXT,description TEXT, price INTEGER,featured_image TEXT, status TEXT, created_at TEXT)');
    });
    return database;
  }

  Future<void> insertProductDetail(ProductDetails productDetails) async {
    //local database variable
    final curDB = await openDB();
    //insert function
    await curDB.insert(
      //first parameter is Table name
      'ProductDetails',
      //second parameter is data to be inserted
      productDetails.mapProductDetails(),
      //replace if two same entries are inserted
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ProductDetails>> getProductDetails() async {
    final curDB = await openDB();
    //query to get all students into a Map list
    final List<Map<String, dynamic>> productDetails = await curDB.query('ProductDetails');
    //converting the map list to student list
    return List.generate(productDetails.length, (i) {
      //loop to traverse the list and return student object
      return ProductDetails(
        id: productDetails[i]['id'],
        slug: productDetails[i]['slug'],
        title: productDetails[i]['title'],
        description: productDetails[i]['description'],
        price: productDetails[i]['price'],
        featured_image: productDetails[i]['featured_image'],
        status: productDetails[i]['status'],
        created_at: DateTime.parse(productDetails[i]['created_at']),
      );
    });
  }

  Future<void> deleteProductDetail(String id) async {
    final curDB = await openDB();
    // Delete operation
    await curDB.delete(
      //table name
      'ProductDetails',
      //'where statement to identify a specific student'
      where: 'id = ?',
      //arguments to the where statement(email passed as parameter in our case)
      whereArgs: [id],
    );
  }
}
