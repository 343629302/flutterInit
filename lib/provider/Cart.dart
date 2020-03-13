import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  List _cartList = [];
  addList(value) {
    this._cartList.add(value);
    //表示通知其他页面更新状态
    notifyListeners();
  }

  List get cartList => this._cartList;
  int get cartNum => this._cartList.length;
}
