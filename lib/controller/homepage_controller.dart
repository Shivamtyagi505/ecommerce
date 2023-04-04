import 'package:ecommerce/model/product.dart';
import 'package:ecommerce/service/base_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../database/local_db.dart';

class HomePageController extends GetxController {
  List<ProductDetails> allProducts = [];
  List<ProductDetails> localAllProducts = [];
  final service = BaseService();
  final db = LocalDatabase();
  bool isLoading = false;
  var scrollController = ScrollController();

  int get grandTotal {
    if (localAllProducts.isNotEmpty) {
      return localAllProducts.fold(0, (previousValue, element) => previousValue + element.price!);
    }
    return 0;
  }

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    isLoading = true;
    update();
    try {
      var result = await service.getProducts();
      if (result.data != null) {
        allProducts = result.data!;
      }
    } catch (e) {
      Exception(e);
    }
    isLoading = false;
    update();
  }

  Future<void> getProductDetails() async {
    localAllProducts = await db.getProductDetails();
    update();
  }

  Future<void> insertProduct(ProductDetails productDetails) async {
    await db.insertProductDetail(productDetails);
    productDetails.isAdded = true;
    update();
  }

  Future<void> deleteProduct(ProductDetails productDetails) async {
    await db.deleteProductDetail(productDetails.id.toString());
  }
}
