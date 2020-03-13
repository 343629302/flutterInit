import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';
import 'package:dio/dio.dart';
import '../../config/Config.dart';
import '../../model/CateModel.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  int _seleteIndex = 0;
  List<CateItemModel> _leftCateList = [];
  List<CateItemModel> _rightCateList = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    this._getLeftCateData();
  }

  _getLeftCateData() async {
    final api = '${Config.domain}api/pcate';
    final res = await Dio().get(api);
    final leftCateList = CateModel.fromJson(res.data);
    setState(() {
      this._leftCateList = leftCateList.result;
      this._getRightCateData(leftCateList.result[0].sId);
    });
  }

  _getRightCateData(pid) async {
    final api = '${Config.domain}api/pcate?pid=${pid}';
    final res = await Dio().get(api);
    final rightCateList = CateModel.fromJson(res.data);
    setState(() {
      this._rightCateList = rightCateList.result;
    });
  }

  Widget _leftCateWidget(lefWidth) {
    if (this._leftCateList.length > 0) {
      return Container(
        child: ListView.builder(
          itemCount: this._leftCateList.length,
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    setState(() {
                      this._seleteIndex = index;
                      this._getRightCateData(this._leftCateList[index].sId);
                    });
                  },
                  child: Container(
                    height: ScreenAdapter.height(84),
                    padding: EdgeInsets.only(top: ScreenAdapter.height(24)),
                    child: Text(
                      '${this._leftCateList[index].title}',
                      textAlign: TextAlign.center,
                    ),
                    width: double.infinity,
                    color: this._seleteIndex == index
                        ? Color.fromRGBO(240, 246, 246, 0.9)
                        : Colors.white,
                  ),
                ),
                Divider(
                  height: 1,
                )
              ],
            );
          },
        ),
        height: double.infinity,
        width: lefWidth,
      );
    } else {
      return Container(
        height: double.infinity,
        width: lefWidth,
      );
    }
  }

  Widget _rightCateWidget(rightItemWidth, rightItemHeight) {
    if (this._rightCateList.length > 0) {
      return Expanded(
        child: Container(
          padding: EdgeInsets.all(10),
          height: double.infinity,
          color: Color.fromRGBO(240, 246, 246, 0.9),
          child: GridView.builder(
              //配置其他属性
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //每行有多少个数据
                  crossAxisCount: 3,
                  //每条数据的宽高比
                  childAspectRatio: rightItemWidth / rightItemHeight,
                  //副轴间距
                  crossAxisSpacing: 10,
                  //主轴间距
                  mainAxisSpacing: 10),
              //数据长度
              itemCount: this._rightCateList.length,
              //每条数据的内容
              itemBuilder: (context, index) {
                String pic = this._rightCateList[index].pic;
                pic = Config.domain + pic.replaceAll('\\', '/');
                return InkWell(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: 1 / 1,
                          child: Image.network(
                            '${pic}',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          height: ScreenAdapter.height(28),
                          child: Text('${this._rightCateList[index].title}'),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/productList',
                        arguments: {"cid": this._rightCateList[index].sId});
                  },
                );
              }),
        ),
        flex: 1,
      );
    } else {
      return Expanded(
        flex: 1,
        child: Container(
          child: Center(
            child: Text('加载中'),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
//计算右侧GridView宽高比
    final lefWidth = ScreenAdapter.getScreenWidth() / 4;
    final rightItemWidth = ScreenAdapter.width(
        (ScreenAdapter.getScreenWidth() - (lefWidth + 40)) / 3);
    final rightItemHeight = rightItemWidth + ScreenAdapter.height(28);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.center_focus_weak,
              size: 28,
              color: Colors.black87,
            ),
            onPressed: null),
        title: InkWell(
          child: Container(
            height: ScreenAdapter.height(68),
            decoration: BoxDecoration(
                color: Color.fromRGBO(233, 233, 233, .8),
                borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.only(left: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.search),
                Text(
                  '笔记本',
                  style: TextStyle(fontSize: ScreenAdapter.size(28)),
                )
              ],
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, '/search');
          },
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.message,
                size: 28,
                color: Colors.black87,
              ),
              onPressed: null),
        ],
      ),
      body: Row(
        children: <Widget>[
          this._leftCateWidget(lefWidth),
          this._rightCateWidget(rightItemWidth, rightItemHeight)
        ],
      ),
    );
  }
}
