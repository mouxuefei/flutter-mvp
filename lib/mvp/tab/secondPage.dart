import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvp/base/BaseNoTitleWidget.dart';
import 'package:flutter_mvp/utils/sp_utils/sp_constant.dart';
import 'package:flutter_mvp/utils/sp_utils/sp_utils.dart';

class SecondInnerPage extends BaseInnerWidget {
  @override
  getState() {
    return _MyInnerSecondState();
  }

}

class _MyInnerSecondState extends BaseInnerWidgetState<SecondInnerPage> {
  int _number = 1;

  @override
  Widget buildWidget(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          RaisedButton(
            child: Text("存数据累加"),
            onPressed: () {
              SpUtils().put(SpConstanst.PHONE_NUMBER, "${_number++}");
            },
          ),
          RaisedButton(
            child: Text("读数据"),
            onPressed: () {
              log(SpUtils().getString(SpConstanst.PHONE_NUMBER));
              showToastDialog(SpUtils().getString(SpConstanst.PHONE_NUMBER));
            },
          ),
          RaisedButton(
            child: Text("点击弹出吐司"),
            onPressed: () {
              showToast("来自闯过五千年的伤~");
            },
          ),
          RaisedButton(
            child: Text("点击弹出对话框"),
            onPressed: () {
              showToastDialog("这是一个很寂寞的夜 ，下着 有些伤心的雨 ~ ", callBack: () {
                showToast("食6啦。。。");
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  double getVerticalMargin() {
    return getTopBarHeight() + getAppBarHeight() + 55;
  }
}
