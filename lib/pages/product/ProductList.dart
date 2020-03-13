import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';
import 'package:dio/dio.dart';
import '../../config/Config.dart';
import '../../model/ProductModel.dart';
import '../../components/LoadingWidget.dart';
import '../../services/SearchServices.dart';

class ProductListPage extends StatefulWidget {
  Map arguments;
  ProductListPage({Key key, this.arguments}) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  //上拉分页
  ScrollController _scrollController = ScrollController();
  //widget.arguments 监听父级的参数
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _page = 1;
  List<ProductItemModel> _productList = [];
  String _sort = '';
  bool loading = false;
  bool hasMore = true;
  List _subHeaderList = [
    {"id": 1, "title": "综合", "fileds": "all", "sort": -1},
    {"id": 2, "title": "销量", "fileds": "salecount", "sort": -1},
    {"id": 3, "title": "价格", "fileds": "price", "sort": -1},
    {"id": 4, "title": "筛选"}
  ];
  int _selectHeaderId = 1;
  TextEditingController _initKeywordsController = TextEditingController();

  @override
  initState() {
    super.initState();
    this._scrollController.addListener(() {
      final scrollDistance = _scrollController.position.pixels;
      final totalDistance = _scrollController.position.maxScrollExtent;
      if (scrollDistance > totalDistance - 40) {
        this._getProductListData();
      }
    });

    //给search赋值
    this._initKeywordsController.text =
        '${widget.arguments["keywords"] == null ? '' : widget.arguments["keywords"]}';

    this._getProductListData();
  }

  _getProductListData() async {
    if (this.loading || !this.hasMore) {
      return;
    }
    setState(() {
      this.loading = true;
    });
    final str = this._initKeywordsController.text != ''
        ? 'search=${this._initKeywordsController.text}'
        : 'cid=${widget.arguments["cid"]}';
    final api =
        '${Config.domain}api/plist?${str}&page=${this._page}&sort=${this._sort}';
    final res = await Dio().get(api);
    final productList = ProductModel.fromJson(res.data);
    setState(() {
      if (productList.result.length < 10) {
        this.hasMore = false;
      }
      this._productList.addAll(productList.result);
      this._page++;
      this.loading = false;
    });
  }

  _subHeaderChange(id) {
    setState(() {
      this._selectHeaderId = id;
      if (id == 4) {
        this._scaffoldKey.currentState.openEndDrawer();
      } else {
        this._sort =
            '${this._subHeaderList[id - 1]["fileds"]}_${this._subHeaderList[id - 1]["sort"]}';
        this._page = 1;
        this._productList = [];
        this.hasMore = true;
        //回到顶部
        this._scrollController.jumpTo(0);
        this._getProductListData();
      }
    });
  }

  Widget _productListWidget() {
    if (this._productList.length > 0) {
      return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top: ScreenAdapter.height(80)),
        child: ListView.builder(
            controller: this._scrollController,
            itemCount: this._productList.length,
            itemBuilder: (context, index) {
              String pic = this._productList[index].pic;
              pic = Config.domain + pic.replaceAll('\\', '/');
              return Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: ScreenAdapter.width(180),
                        height: ScreenAdapter.height(180),
                        child: Image.network(
                          pic,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Container(
                            height: ScreenAdapter.height(180),
                            margin: EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '${this._productList[index].title}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '￥${this._productList[index].price}',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 16),
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                  Divider(
                    height: ScreenAdapter.height(20),
                  ),
                  this.hasMore && index == this._productList.length - 1
                      ? LoadingWidget()
                      : Text(''),
                  !this.hasMore && index == this._productList.length - 1
                      ? Text('我也是有底线的~~~~~~~~')
                      : Text('')
                ],
              );
            }),
      );
    } else {
      return LoadingWidget();
    }
  }

  Widget _subHeaderWidget() {
    return Positioned(
        top: 0,
        height: ScreenAdapter.height(80),
        width: ScreenAdapter.width(750),
        child: Container(
          height: ScreenAdapter.height(80),
          width: ScreenAdapter.width(750),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 1, color: Color.fromRGBO(233, 233, 233, .9)))),
          child: Row(
              children: this._subHeaderList.map((item) {
            return Expanded(
                flex: 1,
                child: InkWell(
                  child: Container(
                      height: ScreenAdapter.height(80),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '${item['title']}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: this._selectHeaderId == item['id']
                                    ? Colors.red
                                    : Colors.black54),
                          ),
                          this._showIcon(item['id']),
                        ],
                      )),
                  onTap: () {
                    this._subHeaderChange(item['id']);
                  },
                ));
          }).toList()),
        ));
  }

  Widget _showIcon(id) {
    if (id == 2 || id == 3) {
      if (this._subHeaderList[id - 1]["sort"] == -1) {
        return Icon(Icons.arrow_drop_up);
      }
      return Icon(Icons.arrow_drop_down);
    }
    return Text('');
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
        key: this._scaffoldKey,
        appBar: AppBar(
            title: Container(
              padding: EdgeInsets.only(left: 25, right: 25),
              height: ScreenAdapter.height(68),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(233, 233, 233, .8),
                  borderRadius: BorderRadius.circular(30)),
              child: TextField(
                //默认选中
                autofocus: false,
                controller: this._initKeywordsController,
                onSubmitted: (val) {
                  this._initKeywordsController.text = val;
                  this._page = 1;
                  this._productList = [];
                  this.hasMore = true;
                  this._getProductListData();
                  SearchServices.setSearchData(val);
                },
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            actions: <Widget>[Text('')]),
        //右边侧边栏
        endDrawer: Drawer(
          child: Container(
            child: Text('实现筛选功能'),
          ),
        ),
        body: Stack(
          children: <Widget>[
            this._productListWidget(),
            this._subHeaderWidget()
          ],
        ));
  }

  static newGlobalKey() {}
}
