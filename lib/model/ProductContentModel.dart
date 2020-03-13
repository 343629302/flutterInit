import 'package:json_annotation/json_annotation.dart';

part 'ProductContentModel.g.dart';

@JsonSerializable()
class ProductContentModel extends Object {
  @JsonKey(name: 'result')
  Result result;

  ProductContentModel(
    this.result,
  );

  factory ProductContentModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ProductContentModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProductContentModelToJson(this);
}

@JsonSerializable()
class Result extends Object {
  @JsonKey(name: '_id')
  String sId;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'cid')
  String cid;

  @JsonKey(name: 'price')
  String price;

  @JsonKey(name: 'old_price')
  String oldPrice;

  @JsonKey(name: 'is_best')
  Object isBest;

  @JsonKey(name: 'is_hot')
  Object isHot;

  @JsonKey(name: 'is_new')
  Object isNew;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'pic')
  String pic;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'cname')
  String cname;

  @JsonKey(name: 'attr')
  List<Attr> attr;

  @JsonKey(name: 'sub_title')
  String subTitle;

  @JsonKey(name: 'salecount')
  int salecount;

  Result(
    this.sId,
    this.title,
    this.cid,
    this.price,
    this.oldPrice,
    this.isBest,
    this.isHot,
    this.isNew,
    this.status,
    this.pic,
    this.content,
    this.cname,
    this.attr,
    this.subTitle,
    this.salecount,
  );

  factory Result.fromJson(Map<String, dynamic> srcJson) =>
      _$ResultFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class Attr extends Object {
  @JsonKey(name: 'cate')
  String cate;

  @JsonKey(name: 'list')
  List<String> list;

  Attr(
    this.cate,
    this.list,
  );

  factory Attr.fromJson(Map<String, dynamic> srcJson) =>
      _$AttrFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AttrToJson(this);
}
