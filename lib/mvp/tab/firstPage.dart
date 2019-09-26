import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvp/base/BaseNoTitleWidget.dart';
import 'package:flutter_mvp/mvp/home/second_view.dart';
import 'package:flutter_mvp/mvp/tab/secondPage.dart';
import 'package:flutter_mvp/route/router_application.dart';
import 'package:flutter_mvp/widgets/CustomRoute.dart';

class FirstInnerPage extends BaseInnerWidget {
  @override
  getState() {
    return _MyFirstInnerState();
  }

}

class _MyFirstInnerState extends BaseInnerWidgetState<FirstInnerPage> {

  @override
  double getVerticalMargin() {
    return getTopBarHeight() + getAppBarHeight() + 55;
  }

  @override
  Widget buildWidget(BuildContext context) {
    return RaisedButton(
      onPressed: () {
//        Navigator.of(context)
//            .push(CustomRoute(SecondWidget()));
//        Navigator.of(context).pushNamed("/second");
        String route = '/second?name=${Uri.encodeComponent("张三")}&title=${Uri.encodeComponent("你好")}';
        Application.router.navigateTo(context, route,transition: TransitionType.fadeIn);
      },
      child: Text("跳转"),
    );
  }
}
