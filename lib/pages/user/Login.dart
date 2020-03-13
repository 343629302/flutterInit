import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: <Widget>[
          Center(
            child: Container(
              height: ScreenAdapter.height(160),
              width: ScreenAdapter.width(160),
              child: Image.asset(
                'images/login.png',
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}
