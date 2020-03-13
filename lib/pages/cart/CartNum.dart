import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';

class CartNum extends StatefulWidget {
  CartNum({Key key}) : super(key: key);

  @override
  _CartNumState createState() => _CartNumState();
}

class _CartNumState extends State<CartNum> {
  //左侧按钮
  Widget _leftBtn() {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        width: ScreenAdapter.width(45),
        height: ScreenAdapter.height(45),
        child: Text('-'),
      ),
      onTap: () {},
    );
  }

  //中间区域
  Widget _centerArea() {
    return Container(
      alignment: Alignment.center,
      width: ScreenAdapter.width(70),
      height: ScreenAdapter.height(45),
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(width: 1, color: Colors.black12),
              right: BorderSide(width: 1, color: Colors.black12))),
      child: Text('1'),
    );
  }

  //右侧按钮
  Widget _rightBtn() {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        width: ScreenAdapter.width(45),
        height: ScreenAdapter.height(45),
        child: Text('+'),
      ),
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenAdapter.width(165),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: Row(
        children: <Widget>[
          _leftBtn(),
          _centerArea(),
          _rightBtn()
        ],
      ),
    );
  }
}
