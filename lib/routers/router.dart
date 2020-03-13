import 'package:flutter/material.dart';
import '../pages/tabs/Layout.dart';
import '../pages/product/ProductList.dart';
import '../pages/search/Search.dart';
import '../pages/product/ProductContent.dart';
import '../pages/user/Login.dart';

// 配置路由
final Map routes = {
  '/': (context, {arguments}) => LayoutPage(),
  '/productList': (context, {arguments}) => ProductListPage(arguments:arguments),
  '/search': (context) => SearchPage(),
  '/productContent': (context, {arguments}) => ProductContentPage(arguments:arguments),
  '/login': (context) => LoginPage(),
};

// 跳转路由
final Function onGenerateRoute = (RouteSettings settings) {
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
