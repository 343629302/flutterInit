import 'package:flutter/material.dart';

class ProductContentThird extends StatefulWidget {
  ProductContentThird({Key key}) : super(key: key);

  @override
  _ProductContentThirdState createState() => _ProductContentThirdState();
}

class _ProductContentThirdState extends State<ProductContentThird>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('商品评论'),
    );
  }
}
