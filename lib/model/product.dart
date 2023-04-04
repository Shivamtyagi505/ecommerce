// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  int? status;
  String? message;
  int? totalRecord;
  int? totalPage;
  List<ProductDetails>? data;
  Product({this.data, this.message, this.status, this.totalPage, this.totalRecord});

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class ProductDetails {
  int? id;
  String? slug;
  String? title;
  String? description;
  int? price;
  String? featured_image;
  String? status;
  DateTime? created_at;

  // ignore: deprecated_member_use
  @JsonKey(ignore: true)
  bool isAdded;
  ProductDetails({this.created_at, this.description, this.featured_image, this.id, this.price, this.slug, this.status, this.title, this.isAdded = false});

  factory ProductDetails.fromJson(Map<String, dynamic> json) => _$ProductDetailsFromJson(json);

  Map<String, dynamic> mapProductDetails() {
    return {
      'id': id,
      'slug': slug,
      'title': title,
      'description': description,
      'price': price,
      'featured_image': featured_image,
      'status': status,
      'created_at': created_at!.toIso8601String(),
    };
  }

  Map<String, dynamic> toJson() => _$ProductDetailsToJson(this);
}
