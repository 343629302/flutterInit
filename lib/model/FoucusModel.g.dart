// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FoucusModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoucusModel _$FoucusModelFromJson(Map<String, dynamic> json) {
  return FoucusModel(
    (json['result'] as List)
        ?.map((e) => e == null
            ? null
            : FoucusItemModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$FoucusModelToJson(FoucusModel instance) =>
    <String, dynamic>{
      'result': instance.result,
    };

FoucusItemModel _$FoucusItemModelFromJson(Map<String, dynamic> json) {
  return FoucusItemModel(
    json['_id'] as String,
    json['title'] as String,
    json['status'] as String,
    json['pic'] as String,
    json['url'] as String,
  );
}

Map<String, dynamic> _$FoucusItemModelToJson(FoucusItemModel instance) =>
    <String, dynamic>{
      '_id': instance.sId,
      'title': instance.title,
      'status': instance.status,
      'pic': instance.pic,
      'url': instance.url,
    };
