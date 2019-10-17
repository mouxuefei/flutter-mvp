import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvp/base/BaseNoTitleWidget.dart';
import 'package:flutter_mvp/config/UrlConstants.dart';
import 'package:flutter_mvp/model/Article.dart';
import 'package:flutter_mvp/network/HttpGo.dart';
import 'package:flutter_mvp/network/intercept/noaction_intercept.dart';
import 'package:flutter_mvp/network/intercept/showloading_intercept.dart';
import 'package:flutter_mvp/network/http.dart';

class ThirdInnerPage extends BaseInnerWidget {
  @override
  getState() {
    return _MyThirdInnerPageState();
  }

  @override
  int setIndex() {
    return 2;
  }
}

class _MyThirdInnerPageState extends BaseInnerWidgetState<ThirdInnerPage> {
  String _requestData = "";

  @override
  double getVerticalMargin() {
    return getTopBarHeight() + getAppBarHeight() + 55;
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(""),
        RaisedButton(
          child: Text("模拟请求登录"),
          onPressed: () {
            requestLogin();
          },
        ),
        Text(_requestData),
        RaisedButton(
          child: Text("模拟错误请求"),
          onPressed: () {
            requestErrorRequest();
          },
        ),
      ],
    );
  }

  void requestLogin() {
    HttpGo.getInstance()
        .get(UrlConstants.ARTICLE
        , ShowLoadingIntercept(this)
        , (data) {
          var article =Article.fromJson(data);
          showToast(article.data[0].name);
        }
        , errorCallBack: () {

        });
  }

  void requestErrorRequest() {
      setErrorWidgetVisible(true);
  }

}
