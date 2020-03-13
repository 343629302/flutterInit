import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20),
            height: ScreenAdapter.height(220),
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/user_bg.jpg'),
                    fit: BoxFit.cover)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 20),
                  child: ClipOval(
                    child: Image.asset(
                      'images/user.png',
                      fit: BoxFit.cover,
                      width: ScreenAdapter.width(100),
                      height: ScreenAdapter.height(100),
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: InkWell(
                      child: Text(
                        '登录/注册',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: (){
                        Navigator.pushNamed(context, '/login');
                      },
                    ))
                // Expanded(
                //     flex: 1,
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: <Widget>[Text('用户名  2123123132',style: TextStyle(
                //         color:Colors.white,
                //         fontSize: ScreenAdapter.size(32)
                //       ),), Text('普通会员',style: TextStyle(
                //         color: Colors.white
                //       ),)],
                //     ))
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.red,
            ),
            title: Text('全部订单'),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.payment,
              color: Colors.green,
            ),
            title: Text('待支付'),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.local_car_wash,
              color: Colors.orange,
            ),
            title: Text('待收货'),
          ),
          Container(
            width: double.infinity,
            height: 10,
            color: Color.fromRGBO(242, 242, 242, .9),
          ),
          ListTile(
            leading: Icon(
              Icons.favorite,
              color: Colors.lightGreen,
            ),
            title: Text('我的收藏'),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.people,
              color: Colors.black54,
            ),
            title: Text('在线客服'),
          ),
          Divider(),
        ],
      ),
    );
  }
}
