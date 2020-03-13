// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProductModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) {
  return ProductModel(
    (json['result'] as List)
        ?.map((e) => e == null
            ? null
            : ProductItemModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'result': instance.result,
    };

ProductItemModel _$ProductItemModelFromJson(Map<String, dynamic> json) {
  return ProductItemModel(
    json['_id'] as String,
    json['title'] as String,
    json['cid'] as String,
    json['price'],
    json['old_price'] as String,
    json['pic'] as String,
    json['s_pic'] as String,
  );
}

Map<String, dynamic> _$ProductItemModelToJson(ProductItemModel instance) =>
    <String, dynamic>{
      '_id': instance.sId,
      'title': instance.title,
      'cid': instance.cid,
      'price': instance.price,
      'old_price': instance.oldPrice,
      'pic': instance.pic,
      's_pic': instance.sPic,
    };
