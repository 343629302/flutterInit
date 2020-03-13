import 'package:json_annotation/json_annotation.dart';

part 'FoucusModel.g.dart';

@JsonSerializable()
class FoucusModel extends Object {
  @JsonKey(name: 'result')
  List<FoucusItemModel> result;

  FoucusModel(
    this.result,
  );

  factory FoucusModel.fromJson(Map<String, dynamic> srcJson) =>
      _$FoucusModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FoucusModelToJson(this);
}

@JsonSerializable()
class FoucusItemModel extends Object {
  @JsonKey(name: '_id')
  String sId;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'pic')
  String pic;

  @JsonKey(name: 'url')
  String url;

  FoucusItemModel(
    this.sId,
    this.title,
    this.status,
    this.pic,
    this.url,
  );

  factory FoucusItemModel.fromJson(Map<String, dynamic> srcJson) =>
      _$FoucusItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FoucusItemModelToJson(this);
}
