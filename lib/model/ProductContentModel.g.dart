// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProductContentModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductContentModel _$ProductContentModelFromJson(Map<String, dynamic> json) {
  return ProductContentModel(
    json['result'] == null
        ? null
        : Result.fromJson(json['result'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProductContentModelToJson(
        ProductContentModel instance) =>
    <String, dynamic>{
      'result': instance.result,
    };

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
    json['_id'] as String,
    json['title'] as String,
    json['cid'] as String,
    json['price'] as String,
    json['old_price'] as String,
    json['is_best'],
    json['is_hot'],
    json['is_new'],
    json['status'] as String,
    json['pic'] as String,
    json['content'] as String,
    json['cname'] as String,
    (json['attr'] as List)
        ?.map(
            (e) => e == null ? null : Attr.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['sub_title'] as String,
    json['salecount'] as int,
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      '_id': instance.sId,
      'title': instance.title,
      'cid': instance.cid,
      'price': instance.price,
      'old_price': instance.oldPrice,
      'is_best': instance.isBest,
      'is_hot': instance.isHot,
      'is_new': instance.isNew,
      'status': instance.status,
      'pic': instance.pic,
      'content': instance.content,
      'cname': instance.cname,
      'attr': instance.attr,
      'sub_title': instance.subTitle,
      'salecount': instance.salecount,
    };

Attr _$AttrFromJson(Map<String, dynamic> json) {
  return Attr(
    json['cate'] as String,
    (json['list'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$AttrToJson(Attr instance) => <String, dynamic>{
      'cate': instance.cate,
      'list': instance.list,
    };
