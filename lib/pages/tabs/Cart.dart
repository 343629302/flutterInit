import 'package:flutter/material.dart';
import '.././../provider/Cart.dart';
import 'package:provider/provider.dart';
import '../cart/CartItem.dart';
import '../../services/ScreenAdapter.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    final cartProvider = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.launch),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[CartItem(), CartItem()],
          ),
          Positioned(
              bottom: 0,
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(78),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top:BorderSide(
                        width: 1,
                        color: Colors.black12
                      ) 
                    )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Checkbox(value: true, onChanged: (value) {}),
                        Text('全选')
                      ],
                    ),
                    RaisedButton(
                        color: Colors.red,
                        child: Text(
                          '结算',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {})
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
