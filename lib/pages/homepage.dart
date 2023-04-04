import 'package:ecommerce/controller/homepage_controller.dart';
import 'package:ecommerce/pages/my_cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomePageController());
    controller.scrollController.addListener(() {
      var nextPageTrigger = 0.8 * controller.scrollController.position.maxScrollExtent;

// _scrollController fetches the next paginated data when the current postion of the user on the screen has surpassed
      if (controller.scrollController.position.pixels > nextPageTrigger) {
        // controller.fetchProducts();
      }
    });

    return GetBuilder(
        init: controller,
        builder: (_) {
          return Scaffold(
              appBar: AppBar(
                title: Text('Shopping Mall', style: GoogleFonts.lato(color: Colors.white)),
                centerTitle: true,
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const MyCart()));
                      },
                      icon: const Icon(Icons.shopping_cart, color: Colors.white))
                ],
              ),
              body: controller.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: GridView.builder(
                          controller: controller.scrollController,
                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 200, crossAxisSpacing: 20, mainAxisSpacing: 20),
                          itemCount: controller.allProducts.length,
                          itemBuilder: (BuildContext context, int index) {
                            final product = controller.allProducts[index];
                            return Container(
                              padding: const EdgeInsets.only(top: 5),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.grey)),
                              child: Column(
                                children: [
                                  Expanded(child: Image.network(product.featured_image ?? '')),
                                  Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    margin: const EdgeInsets.only(top: 5),
                                    height: 50,
                                    decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.grey))),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(product.title ?? '', style: GoogleFonts.lato(), overflow: TextOverflow.ellipsis),
                                        ),
                                        IconButton(
                                            onPressed: () async {
                                              await controller.insertProduct(product);
                                            },
                                            icon: Icon(
                                              Icons.shopping_cart,
                                              color: product.isAdded ? Colors.blue : Colors.black,
                                            )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    ));
        });
  }
}
