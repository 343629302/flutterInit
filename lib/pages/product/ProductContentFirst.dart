import 'package:flutter/material.dart';
import '../../model/ProductContentModel.dart';
import '../../services/ScreenAdapter.dart';
import '../../config/Config.dart';
import '../../services/EventBus.dart';
import './ProductNum.dart';

class ProductContentFirst extends StatefulWidget {
  Result productContent;
  ProductContentFirst({Key key, this.productContent}) : super(key: key);
  @override
  _ProductContentFirstState createState() => _ProductContentFirstState();
}

class _ProductContentFirstState extends State<ProductContentFirst>
    with AutomaticKeepAliveClientMixin {
  Result _productContent;
  List attr = [];
  bool get wantKeepAlive => true;
  String _selectValue = '';
  int _productNum = 1;
  var actionEventBus;

  @override
  void initState() {
    super.initState();
    this._productContent = widget.productContent;
    this._initAttr(this._productContent.attr);

    this.actionEventBus = eventBus.on<ProductContentEvent>().listen((event) {
      this._attrBottomSheet(context);
    });
  }

  //销毁
  void dispose() {
    super.dispose();
    //取消监听
    this.actionEventBus.cancel();
  }

  void productNumChange(val) {
    setState(() {
      this._productNum = val;
    });
  }

  //初始化attr 格式化数据
  _initAttr(List attr) {
    List newAttr = attr;
    for (int i = 0; i < newAttr.length; i++) {
      List<Map> list = [];
      for (int j = 0; j < newAttr[i].list.length; j++) {
        list.add({"title": newAttr[i].list[j], "check": j == 0 ? true : false});
      }
      this.attr.add({
        "cate": newAttr[i].cate,
        "list": list,
      });
    }
    this._getSelectedAttrValue();
  }

  //改变属性
  _changeValue(item, vItem, setBottomState) {
    List attr = this.attr;
    for (int i = 0; i < attr.length; i++) {
      if (attr[i]['cate'] == item['cate']) {
        for (int j = 0; j < attr[i]['list'].length; j++) {
          attr[i]['list'][j]['title'] == vItem['title']
              ? attr[i]['list'][j]['check'] = true
              : attr[i]['list'][j]['check'] = false;
        }
      }
    }

    setBottomState(() {
      this.attr = attr;
      this._getSelectedAttrValue();
    });
  }

  //获取选中的值
  _getSelectedAttrValue() {
    List _list = this.attr;
    List tempArr = [];
    for (int i = 0; i < _list.length; i++) {
      for (int j = 0; j < _list[i]['list'].length; j++) {
        if (_list[i]['list'][j]['check'] == true) {
          tempArr.add(_list[i]['list'][j]['title']);
        }
      }
    }
    setState(() {
      this._selectValue = tempArr.join(',');
    });
  }

  List<Widget> _getAttrWidget(setBottomState) {
    return this.attr.map<Widget>((item) {
      return Container(
          margin: EdgeInsets.only(top: 10),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 17),
                  alignment: Alignment.center,
                  width: ScreenAdapter.width(100),
                  child: Text(
                    '${item["cate"]}:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Wrap(
                        children:
                            this._getAttrItemWidget(item, setBottomState)))
              ]));
    }).toList();
  }

  List<Widget> _getAttrItemWidget(item, setBottomState) {
    return item["list"].map<Widget>((vItem) {
      return InkWell(
          child: Container(
            padding: EdgeInsets.all(5),
            child: Chip(
              backgroundColor: vItem["check"] ? Colors.red : Colors.black54,
              label: Text(
                '${vItem["title"]}',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          onTap: () {
            this._changeValue(item, vItem, setBottomState);
          });
    }).toList();
  }

  Widget _attrBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        //监听状态修改attrBottom状态
        return StatefulBuilder(builder: (BuildContext context, setBottomState) {
          //GestureDetector 手势事件，该事件有点击事件，但是没有水墨纹
          return GestureDetector(
              onTap: () {
                return false;
              },
              child: Stack(children: <Widget>[
                ListView(
                  children: <Widget>[
                    Column(
                      children: this._getAttrWidget(setBottomState),
                    ),
                    Divider(),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            width: ScreenAdapter.width(100),
                            child: Text(
                              '数量:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: ScreenAdapter.width(180),
                            padding: EdgeInsets.all(5),
                            child: ProductNum(
                                callback: (val) => productNumChange(val)),
                          ),
                        ]),
                  ],
                ),
                Positioned(
                  width: ScreenAdapter.width(750),
                  height: ScreenAdapter.height(76),
                  child: Row(children: <Widget>[
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
                          onTap: () {},
                        )),
                    Expanded(
                        flex: 1,
                        child: InkWell(
                          child: Container(
                            alignment: Alignment.center,
                            height: ScreenAdapter.height(80),
                            color: Color.fromRGBO(253, 1, 0, .9),
                            child: Text(
                              '立即购买',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          onTap: () {},
                        )),
                  ]),
                  bottom: 0,
                )
              ]));
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String pic = Config.domain + this._productContent.pic;
    pic = pic.replaceAll('\\', '/');

    ScreenAdapter.init(context);
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              '${pic}',
              fit: BoxFit.cover,
            ),
          ),
          //标题
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              '${this._productContent.title}',
              style: TextStyle(
                  color: Colors.black54, fontSize: ScreenAdapter.size(36)),
            ),
          ),
          //介绍
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              '${this._productContent.subTitle}',
              style: TextStyle(
                  color: Colors.black54, fontSize: ScreenAdapter.size(25)),
            ),
          ),
          //价格
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('特价'),
                      Text(
                        '￥${this._productContent.price}',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: ScreenAdapter.size(36)),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('原价'),
                      Text(
                        '￥${this._productContent.oldPrice}',
                        style: TextStyle(
                            color: Colors.black38,
                            fontSize: ScreenAdapter.size(28),
                            decoration: TextDecoration.lineThrough),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          //筛选
          Container(
              height: ScreenAdapter.height(80),
              margin: EdgeInsets.only(top: 10),
              child: InkWell(
                onTap: () {
                  this._attrBottomSheet(context);
                },
                child: Row(
                  children: <Widget>[
                    Text(
                      '已选',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('${_selectValue}')
                  ],
                ),
              )),
          Divider(),
          //运费
          Container(
            height: ScreenAdapter.height(80),
            child: Row(
              children: <Widget>[
                Text(
                  '运费',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('免运费')
              ],
            ),
          ),
          Divider()
        ],
      ),
    );
  }
}
