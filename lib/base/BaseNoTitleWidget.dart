import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvp/base/Mvp.dart';
import 'package:flutter_mvp/network/api.dart';

///通常是和 viewpager 联合使用  ， 类似于Android 中的 fragment
/// 不过生命周期 还需要在容器父类中根据tab切换来完善
abstract class BaseInnerWidget extends StatefulWidget {
  BaseInnerWidgetState baseInnerWidgetState;
  @override
  BaseInnerWidgetState createState() {
    baseInnerWidgetState = getState();
    return baseInnerWidgetState;
  }

  BaseInnerWidgetState getState();
  String getStateName() {
    return baseInnerWidgetState.className();
  }
}

abstract class BaseInnerWidgetState<T extends BaseInnerWidget> extends State<T>
    with AutomaticKeepAliveClientMixin , ITopView{
  @override
  void initState() {
    initBaseCommon(this, context);
    setBackIconHinde();
    setTopBarVisible(false);
    setAppBarVisible(false);
    onResume();
    super.initState();
    initView();
  }

  void initView(){

  }
  @override
  void didChangeDependencies() {
    bottomVsrtical = getVerticalMargin();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: getBaseView(context),
    );
  }

  @override
  void dispose() {
    onDestory();
    super.dispose();
  }

  ///返回作为内部页面，垂直方向 头和底部 被占用的 高度
  double getVerticalMargin();

  @override
  bool get wantKeepAlive => true;


  @override
  void toast(String msg) {
    showToast(msg);
  }
  @override
  void showLoading(String msg) {
    setLoadingVisible(true,msg);
  }
  @override
  void dismissLoading() {
    setLoadingVisible(false);
  }

  @override
  String className(){
    String className = context.toString();
    if (className == null) {
      return null;
    }
    className = className.substring(0, className.indexOf("("));
    return className;
  }
}
