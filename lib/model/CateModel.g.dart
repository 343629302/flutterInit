// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CateModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CateModel _$CateModelFromJson(Map<String, dynamic> json) {
  return CateModel(
    (json['result'] as List)
        ?.map((e) => e == null
            ? null
            : CateItemModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CateModelToJson(CateModel instance) => <String, dynamic>{
      'result': instance.result,
    };

CateItemModel _$CateItemModelFromJson(Map<String, dynamic> json) {
  return CateItemModel(
    json['_id'] as String,
    json['title'] as String,
    json['status'],
    json['pic'] as String,
    json['pid'] as String,
    json['sort'] as String,
  );
}

Map<String, dynamic> _$CateItemModelToJson(CateItemModel instance) =>
    <String, dynamic>{
      '_id': instance.sId,
      'title': instance.title,
      'status': instance.status,
      'pic': instance.pic,
      'pid': instance.pid,
      'sort': instance.sort,
    };
