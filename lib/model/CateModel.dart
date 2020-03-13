import 'package:json_annotation/json_annotation.dart';

part 'CateModel.g.dart';

@JsonSerializable()
class CateModel extends Object {
  @JsonKey(name: 'result')
  List<CateItemModel> result;

  CateModel(
    this.result,
  );

  factory CateModel.fromJson(Map<String, dynamic> srcJson) =>
      _$CateModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CateModelToJson(this);
}

@JsonSerializable()
class CateItemModel extends Object {
  @JsonKey(name: '_id')
  String sId;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'status')
  Object status;

  @JsonKey(name: 'pic')
  String pic;

  @JsonKey(name: 'pid')
  String pid;

  @JsonKey(name: 'sort')
  String sort;

  CateItemModel(
    this.sId,
    this.title,
    this.status,
    this.pic,
    this.pid,
    this.sort,
  );

  factory CateItemModel.fromJson(Map<String, dynamic> srcJson) =>
      _$CateItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CateItemModelToJson(this);
}
