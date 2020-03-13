import 'package:flutter/material.dart';
import './Cart.dart';
import './Home.dart';
import './User.dart';
import './Category.dart';
import '../../services/ScreenAdapter.dart';

class LayoutPage extends StatefulWidget {
  LayoutPage({Key key}) : super(key: key);

  @override
  _LayoutPageState createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  int _currentIndex = 0;
  PageController _pageController;
  List<Widget> _pageList = [HomePage(), CategoryPage(), CartPage(), UserPage()];

  @override
  void initState() {
    super.initState();
    this._pageController = PageController(
      initialPage: this._currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
        body: PageView(
          controller: this._pageController,
          children: this._pageList,
          //滑动转页的时候可以控制tabbar的current
          // onPageChanged: (index) {
          //   setState(() {
          //     this._currentIndex = index;
          //   });
          // },
          //禁止pageView滑动
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          //当前的位置
          currentIndex: this._currentIndex,
          onTap: (index) {
            setState(() {
              this._currentIndex = index;
              this._pageController.jumpToPage(index);
            });
          },
          //当tabbar大于4个的时候必须配置该属性
          type: BottomNavigationBarType.fixed,
          // 选中的颜色
          fixedColor: Colors.red,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), title: Text('分类')),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), title: Text('购物车')),
            BottomNavigationBarItem(icon: Icon(Icons.people), title: Text('我的'))
          ],
        ));
  }
}
