// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ProductDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
      status: json['status'] as int?,
      totalPage: json['totalPage'] as int?,
      totalRecord: json['totalRecord'] as int?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'totalRecord': instance.totalRecord,
      'totalPage': instance.totalPage,
      'data': instance.data,
    };

ProductDetails _$ProductDetailsFromJson(Map<String, dynamic> json) =>
    ProductDetails(
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      description: json['description'] as String?,
      featured_image: json['featured_image'] as String?,
      id: json['id'] as int?,
      price: json['price'] as int?,
      slug: json['slug'] as String?,
      status: json['status'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$ProductDetailsToJson(ProductDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slug': instance.slug,
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'featured_image': instance.featured_image,
      'status': instance.status,
      'created_at': instance.created_at?.toIso8601String(),
    };
