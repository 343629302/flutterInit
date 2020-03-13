import 'package:flutter/material.dart';
import './routers/router.dart';
import 'package:provider/provider.dart';
import './provider/Cart.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override 
  Widget build(BuildContext context) {
    //MultiProvider 全局配置Provider
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Cart()),
      ],
      child: MaterialApp(
        // 去掉debug图标
        debugShowCheckedModeBanner: false,
        // 主题
        theme: ThemeData(primaryColor: Colors.white),
        //配置初始化路由
        initialRoute: '/',
        //配置路由
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }
}
