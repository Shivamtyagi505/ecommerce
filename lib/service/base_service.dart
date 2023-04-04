import 'dart:convert';

import 'package:ecommerce/model/product.dart';
import 'package:http/http.dart' as http;

class BaseService {
  Future<Product> getProducts() async {
    var response = await http.get(Uri.parse('http://205.134.254.135/~mobile/MtProject/public/api/product_list.php'));

    if (response.statusCode == 200) {
      return Product.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load products');
    }
  }

  //if api will work then I will call post method with this method

  Future<Product> getProductsWithPost(int page, int perPage) async {
    final http.Response response = await http.post(
      Uri.parse('http://205.134.254.135/~mobile/MtProject/public/api/product_list.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'eyJhdWQiOiI1IiwianRpIjoiMDg4MmFiYjlmNGU1MjIyY2MyNjc4Y2FiYTQwOGY2MjU4Yzk5YTllN2ZkYzI0NWQ4NDMxMTQ4ZWMz',
      },
      body: jsonEncode({"page": page, "perPage": perPage}),
    );

    if (response.statusCode == 201) {
      return Product.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create album.');
    }
  }
}
