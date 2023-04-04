import 'package:ecommerce/controller/homepage_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCart extends StatelessWidget {
  const MyCart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomePageController());
    controller.getProductDetails();
    return GetBuilder(
        init: controller,
        builder: (_) {
          return Scaffold(
              bottomSheet: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                color: Colors.blue[100],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Items : ${controller.localAllProducts.length}', style: GoogleFonts.lato()),
                    Text('Grand Total : ${controller.grandTotal}', style: GoogleFonts.lato()),
                  ],
                ),
              ),
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text('My Cart', style: GoogleFonts.lato(color: Colors.white)),
                centerTitle: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              body: controller.localAllProducts.isEmpty
                  ? Center(child: Text('No Products!!', style: GoogleFonts.lato()))
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 50.0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.localAllProducts.length,
                          itemBuilder: (BuildContext context, int index) {
                            final product = controller.localAllProducts[index];
                            return Dismissible(
                                key: Key(product.id.toString()),
                                onDismissed: ((direction) {
                                  controller.deleteProduct(product);
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${product.title} is dismissed')));
                                }),
                                child: Container(
                                    height: 200,
                                    margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.grey),
                                      boxShadow: const [
                                        BoxShadow(color: Colors.grey, offset: Offset(5.0, 5.0), blurRadius: 10.0, spreadRadius: 2.0), //BoxShadow
                                        BoxShadow(color: Colors.white, offset: Offset(0.0, 0.0), blurRadius: 0.0, spreadRadius: 0.0), //BoxShadow
                                      ],
                                    ),
                                    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Image.network(product.featured_image ?? ''),
                                      const VerticalDivider(),
                                      Expanded(
                                          child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 20.0),
                                                  child: Text(product.title ?? '', style: GoogleFonts.lato(fontSize: 18), overflow: TextOverflow.ellipsis),
                                                ),
                                                Padding(
                                                    padding: const EdgeInsets.only(top: 30.0),
                                                    child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [Text('Price', style: GoogleFonts.lato()), Text(product.price.toString(), style: GoogleFonts.lato())])),
                                                Padding(
                                                    padding: const EdgeInsets.only(top: 30.0),
                                                    child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [Text('Quantity', style: GoogleFonts.lato()), Text(product.status ?? '', style: GoogleFonts.lato())]))
                                              ])))
                                    ])));
                          })));
        });
  }
}
