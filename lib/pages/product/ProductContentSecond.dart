import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../model/ProductContentModel.dart';

class ProductContentSecond extends StatefulWidget {
  Result productContent;
  ProductContentSecond({Key key, this.productContent}) : super(key: key);

  @override
  _ProductContentSecondState createState() => _ProductContentSecondState();
}

class _ProductContentSecondState extends State<ProductContentSecond>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: WebView(
      initialUrl:
          'http://jd.itying.com/pcontent?id=${widget.productContent.sId}',
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) {},
    ));
  }
}
