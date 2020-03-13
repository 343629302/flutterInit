import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:it_shopping_app/model/ProductModel.dart';
import '../../services/ScreenAdapter.dart';
import 'package:dio/dio.dart';
import '../../model/FoucusModel.dart';
import '../../config/Config.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  List<FoucusItemModel> _focusData = [];
  List<ProductItemModel> _hotProductList = [];
  List<ProductItemModel> _bestProductList = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    this._getFocusData();
    this._getHotProductData();
    this._getBestProductData();
  }

//获取轮播图数据
  _getFocusData() async {
    final api = '${Config.domain}api/focus';
    final res = await Dio().get(api);
    final focusList = FoucusModel.fromJson(res.data);
    setState(() {
      this._focusData = focusList.result;
    });
  }

  //获取猜你喜欢数据
  _getHotProductData() async {
    final api = '${Config.domain}api/plist?is_hot=1';
    final res = await Dio().get(api);
    final hotProductList = ProductModel.fromJson(res.data);
    setState(() {
      this._hotProductList = hotProductList.result;
    });
  }

  //获取热门数据数据
  _getBestProductData() async {
    final api = '${Config.domain}api/plist?is_best=1';
    final res = await Dio().get(api);
    final bestProductList = ProductModel.fromJson(res.data);
    setState(() {
      this._bestProductList = bestProductList.result;
    });
  }

  //轮播图
  Widget _swiperWidget() {
    if (this._focusData.length > 0) {
      return Swiper(
        itemBuilder: (BuildContext context, int index) {
          String pic = this._focusData[index].pic;
          return Image.network(
            '${Config.domain}${pic.replaceAll('\\', '/')}',
            fit: BoxFit.fill,
          );
        },
        itemCount: this._focusData.length,
        pagination: new SwiperPagination(),
        //自动轮播
        autoplay: true,
        // control: new SwiperControl(),
      );
    } else {
      return Text('加载中');
    }
  }

  //标题组件
  Widget _titleWidget(String title) {
    return Container(
      height: ScreenAdapter.height(32),
      margin: EdgeInsets.only(left: ScreenAdapter.width(20)),
      padding: EdgeInsets.only(left: ScreenAdapter.width(20)),
      child: Text(
        title,
        style: TextStyle(color: Colors.black54),
      ),
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
                  color: Colors.red, width: ScreenAdapter.width(6)))),
    );
  }

  //热门商品
  Widget _hotProductListWidget() {
    if (this._hotProductList.length > 0) {
      return Container(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        height: ScreenAdapter.height(240),
        // width: double.infinity,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            String sPic = this._hotProductList[index].sPic;
            sPic = Config.domain + sPic.replaceAll('\\', '/');
            return InkWell(
              child: Column(
                children: <Widget>[
                  Container(
                    height: ScreenAdapter.height(140),
                    width: ScreenAdapter.width(140),
                    margin: EdgeInsets.only(
                        right: ScreenAdapter.width(21),
                        bottom: ScreenAdapter.width(20)),
                    child: Image.network(
                      sPic,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    '￥${this._hotProductList[index].price}',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
              onTap: () {
                Navigator.pushNamed(context, '/productContent',
                    arguments: {"id": this._hotProductList[index].sId});
              },
            );
          },
          itemCount: this._hotProductList.length,
        ),
      );
    } else {
      return Text('');
    }
  }

  //推介商品
  Widget _recProductWidget() {
    final itemWidth = (ScreenAdapter.getScreenWidth() - 30) / 2;
    return Container(
      padding: EdgeInsets.all(10),
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: this._bestProductList.map((item) {
          String sPic = item.sPic;
          sPic = Config.domain + sPic.replaceAll('\\', '/');
          return InkWell(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12, width: 1)),
              width: itemWidth,
              child: Column(
                children: <Widget>[
                  Container(
                    //商品图片
                    child: Image.network(sPic, fit: BoxFit.cover),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: ScreenAdapter.height(20)),
                    child: Text(
                      //商品标题
                      item.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: ScreenAdapter.height(20)),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            //商品减价后价格
                            '￥${item.price}',
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            //商品原价
                            '￥${item.oldPrice}',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                decoration: TextDecoration.lineThrough),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/productContent',
                  arguments: {"id": item.sId});
            },
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
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
      body: Container(
        child: ListView(
          children: <Widget>[
            //轮播图
            Container(
                child: AspectRatio(
              aspectRatio: 2 / 1,
              child: this._swiperWidget(),
            )),
            //间隔
            SizedBox(height: ScreenAdapter.height(20)),
            //猜你喜欢
            this._titleWidget('猜你喜欢'),
            SizedBox(height: ScreenAdapter.height(20)),
            this._hotProductListWidget(),
            //热门推介
            this._titleWidget('热门推介'),
            this._recProductWidget()
          ],
        ),
      ),
    );
    // return Container(
    //   child: ListView(
    //     children: <Widget>[
    //       //轮播图
    //       Container(
    //           child: AspectRatio(
    //         aspectRatio: 2 / 1,
    //         child: this._swiperWidget(),
    //       )),
    //       //间隔
    //       SizedBox(height: ScreenAdapter.height(20)),
    //       //猜你喜欢
    //       this._titleWidget('猜你喜欢'),
    //       SizedBox(height: ScreenAdapter.height(20)),
    //       this._hotProductListWidget(),
    //       //热门推介
    //       this._titleWidget('热门推介'),
    //       this._recProductWidget()
    //     ],
    //   ),
    // );
  }
}
