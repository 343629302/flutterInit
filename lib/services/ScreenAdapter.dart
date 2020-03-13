import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenAdapter {
  static init(context) {
    ScreenUtil.init(context,
        //设计稿中设备的屏幕尺寸
        width: 750,
        //设计稿中设备的屏幕尺寸
        height: 1334,
        //字体的大小是否根据系统来设置
        allowFontScaling: true);
  }

  //获取自适应后的高度
  static height(double value) {
    return ScreenUtil().setHeight(value);
  }

  //获取自适应后的宽度
  static width(double value) {
    return ScreenUtil().setWidth(value);
  }

  //设备的高度
  static getScreenHeight() {
    return ScreenUtil.screenHeightDp;
  }

  //设备的宽度
  static getScreenWidth() {
    return ScreenUtil.screenWidthDp;
  }

  //获取自适应后的字体大小
  static size(double value) {
    return ScreenUtil().setSp(value);
  }
}
