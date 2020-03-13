import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';

class ProductNum extends StatefulWidget {
  final callback;
  ProductNum({Key key, this.callback}) : super(key: key);

  @override
  _ProductNumState createState() => _ProductNumState();
}

class _ProductNumState extends State<ProductNum> {
  int _productNum = 1;
  //左侧按钮
  Widget _leftBtn() {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        width: ScreenAdapter.width(45),
        height: ScreenAdapter.height(45),
        child: Text('-'),
      ),
      onTap: () {
        setState(() {
          if (this._productNum > 1) {
            this._productNum--;
          }
          widget.callback(this._productNum);
        });
      },
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
      child: Text('${this._productNum}'),
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
      onTap: () {
        setState(() {
          this._productNum++;
          widget.callback(this._productNum);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenAdapter.width(165),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: Row(
        children: <Widget>[_leftBtn(), _centerArea(), _rightBtn()],
      ),
    );
  }
}
