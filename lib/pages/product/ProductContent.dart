import 'package:flutter/material.dart';
import './ProductContentFirst.dart';
import './ProductContentSecond.dart';
import './ProductContentThird.dart';
import '../../services/ScreenAdapter.dart';
import 'package:dio/dio.dart';
import '../../config/Config.dart';
import '../../model/ProductContentModel.dart';
import '../../components/LoadingWidget.dart';
import '../../services/EventBus.dart';

class ProductContentPage extends StatefulWidget {
  Map arguments;
  ProductContentPage({Key key, this.arguments}) : super(key: key);

  @override
  _ProductContentPageState createState() => _ProductContentPageState();
}

class _ProductContentPageState extends State<ProductContentPage>{
  Result productContent;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    this._getContentData();
  }

  _getContentData() async {
    final api = '${Config.domain}api/pcontent?id=${widget.arguments['id']}';
    final res = await Dio().get(api);
    final productContent = ProductContentModel.fromJson(res.data);
    setState(() {
      this.productContent = productContent.result;
      this.loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: Center(
              child: Container(
                width: ScreenAdapter.width(400),
                child: TabBar(tabs: <Widget>[
                  Tab(
                    text: '商品',
                  ),
                  Tab(
                    text: '详情',
                  ),
                  Tab(
                    text: '评价',
                  ),
                ]),
              ),
            ),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.more_horiz),
                  onPressed: () {
                    showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(
                            ScreenAdapter.width(600), 70, 10, 0),
                        items: [
                          PopupMenuItem(
                              child: Row(
                            children: <Widget>[Icon(Icons.home), Text('首页')],
                          )),
                          PopupMenuItem(
                              child: Row(
                            children: <Widget>[Icon(Icons.search), Text('搜索')],
                          ))
                        ]);
                  })
            ],
          ),
          body: this.loading ?LoadingWidget()  :Stack(
            children: <Widget>[
              TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                ProductContentFirst(productContent: this.productContent),
                ProductContentSecond(productContent: this.productContent),
                ProductContentThird()
              ]),
              Positioned(
                  bottom: 0,
                  width: ScreenAdapter.width(750),
                  height: ScreenAdapter.height(80),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            top: BorderSide(width: 1, color: Colors.black38))),
                    child: Row(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          width: ScreenAdapter.width(100),
                          height: ScreenAdapter.height(80),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.shopping_cart),
                              Text('购物车')
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: InkWell(
                              child: Container(
                                alignment: Alignment.center,
                                height: ScreenAdapter.height(80),
                                color: Color.fromRGBO(255, 165, 0, .9),
                                child: Text(
                                  '加入购物车',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              onTap: () {
                                eventBus.fire(ProductContentEvent());
                              },
                            )),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            child: Container(
                              alignment: Alignment.center,
                              color: Color.fromRGBO(253, 1, 0, .9),
                              height: ScreenAdapter.height(80),
                              child: Text(
                                '立即购买',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            onTap: () {},
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          )),
    );
  }
}
