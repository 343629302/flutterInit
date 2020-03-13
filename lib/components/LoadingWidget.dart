import 'package:flutter/material.dart';
import '../services/ScreenAdapter.dart';

class LoadingWidget extends StatefulWidget {
  LoadingWidget({Key key}) : super(key: key);

  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //圈圈
            CircularProgressIndicator(
              strokeWidth: 1,
            ),
            Container(
              margin: EdgeInsets.only(top:ScreenAdapter.height(30)),
              child: Text('加载中', style: TextStyle(fontSize: 16)),
            )
          ],
        ),
      ),
    );
  }
}
