import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';
import '../../services/SearchServices.dart';

class SearchPage extends StatefulWidget {
  Map arguments;
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> _historyListData = [];

  void _getHistoryData() async {
    this._historyListData = await SearchServices.getSearchData();
  }

  void _showAlertDialog(String value) async {
    final res = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // 标题
            title: Text('提示信息'),
            // 提示框内容
            content: Text('你确定要删除么'),
            // 按钮组合
            actions: <Widget>[
              RaisedButton(
                child: Text('取消'),
                onPressed: () {
                  // 退出弹出框,当是async await 的时候，pop的第二个参数会传出去
                  Navigator.pop(context, '取消');
                },
              ),
              RaisedButton(
                child: Text('确定'),
                onPressed: () async {
                  await SearchServices.clearSearchRemove(value);
                  setState(() {
                    this._getHistoryData();
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  Widget _historyListWidget() {
    if (this._historyListData.length > 0) {
      return Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              '历史记录',
              style: TextStyle(fontSize: ScreenAdapter.size(30)),
            ),
          ),
          Divider(),
          Column(
              children: this._historyListData.map((value) {
            return Column(
              children: <Widget>[
                ListTile(
                  title: Text('${value}'),
                  //长按
                  onLongPress: () {
                    this._showAlertDialog(value);
                  },
                ),
                Divider()
              ],
            );
          }).toList()),
          SizedBox(
            height: ScreenAdapter.height(100),
          ),
          OutlineButton(
              child: Container(
                height: ScreenAdapter.height(60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.delete),
                    Container(
                      margin: EdgeInsets.only(left: ScreenAdapter.width(10)),
                      child: Text('清空历史记录'),
                    )
                  ],
                ),
              ),
              onPressed: () async {
                await SearchServices.clearSearchData();
                setState(() {
                  this._getHistoryData();
                });
              })
        ],
      );
    } else {
      return Text('');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._getHistoryData();
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
        appBar: AppBar(
          title: Container(
            padding: EdgeInsets.only(left: 25, right: 25),
            height: ScreenAdapter.height(68),
            decoration: BoxDecoration(
                color: Color.fromRGBO(233, 233, 233, .8),
                borderRadius: BorderRadius.circular(30)),
            child: TextField(
              //默认选中
              autofocus: true,
              onSubmitted: (val) {
                SearchServices.setSearchData(val);
                Navigator.pushReplacementNamed(context, '/productList',
                    arguments: {'keywords': val});
              },
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ),
        ),
        body: Container(
          child: ListView(
            padding: EdgeInsets.all(10),
            children: <Widget>[
              Container(
                child: Text(
                  '热搜',
                  style: TextStyle(fontSize: ScreenAdapter.size(30)),
                ),
              ),
              Divider(),
              Wrap(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromRGBO(233, 233, 233, .9),
                    ),
                    child: Text('女装'),
                  )
                ],
              ),
              SizedBox(
                height: ScreenAdapter.height(50),
              ),
              this._historyListWidget()
            ],
          ),
        ));
  }
}
