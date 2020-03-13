import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';
import './CartNum.dart';

class CartItem extends StatefulWidget {
  CartItem({Key key}) : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenAdapter.height(200),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black12, width: 1))),
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenAdapter.width(60),
            child: Checkbox(
              value: true,
              onChanged: (val) {},
              activeColor: Colors.pink,
            ),
          ),
          Container(
            width: ScreenAdapter.width(160),
            child: Image.network(
              "https://www.itying.com/images/flutter/list2.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '名称',
                      maxLines: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '￥1000',
                          style: TextStyle(color: Colors.red),
                        ),
                        CartNum(),
                      ],
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
