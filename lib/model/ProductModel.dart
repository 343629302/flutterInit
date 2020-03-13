import 'package:json_annotation/json_annotation.dart';

part 'ProductModel.g.dart';

@JsonSerializable()
class ProductModel extends Object {
  @JsonKey(name: 'result')
  List<ProductItemModel> result;

  ProductModel(
    this.result,
  );

  factory ProductModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ProductModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}

@JsonSerializable()
class ProductItemModel extends Object {
  @JsonKey(name: '_id')
  String sId;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'cid')
  String cid;

  @JsonKey(name: 'price')
  Object price;

  @JsonKey(name: 'old_price')
  String oldPrice;

  @JsonKey(name: 'pic')
  String pic;

  @JsonKey(name: 's_pic')
  String sPic;

  ProductItemModel(
    this.sId,
    this.title,
    this.cid,
    this.price,
    this.oldPrice,
    this.pic,
    this.sPic,
  );

  factory ProductItemModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ProductItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProductItemModelToJson(this);
}
