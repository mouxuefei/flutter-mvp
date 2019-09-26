import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvp/base/NavigatorManger.dart';
import 'package:flutter_mvp/base/Mvp.dart';
import 'package:flutter_mvp/network/api.dart';

abstract class BaseWidget extends StatefulWidget  {
  BaseWidgetState baseWidgetState;
  @override
  BaseWidgetState createState() {
    baseWidgetState = getState();
    return baseWidgetState;
  }
  //通过子类获取
  BaseWidgetState getState();
}

abstract class BaseWidgetState<T extends BaseWidget> extends State<T>
    with WidgetsBindingObserver,ITopView {
  bool _onResumed = false; //页面展示标记
  bool _onPause = false; //页面暂停标记
  @override
  void initState() {
    initBaseCommon(this, context);
    NavigatorManger().addWidget(this);
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    initView();
  }

  void  initView(){

  }

  ///在dispose之前，会调用这个函数。实测在组件可见状态变化的时候会调用，当组件卸载时也会先一步dispose调用。
  @override
  void deactivate() {
    //说明是被覆盖了
    if (NavigatorManger().isSecondTop(this)) {
      if (!_onPause) {
        onPause();
        _onPause = true;
      } else {
        onResume();
        _onPause = false;
      }
    } else if (NavigatorManger().isTopPage(this)) {
      if (!_onPause) {
        onPause();
      }
    }
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    if (!_onResumed) {
      //说明是 初次加载
      if (NavigatorManger().isTopPage(this)) {
        _onResumed = true;
        onResume();
      }
    }
    return Scaffold(
      body: getBaseView(context),
    );
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

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log("AppLifecycleState----"+state.toString());
    //此处可以拓展 是不是从前台回到后台
    if (state == AppLifecycleState.resumed) {
      //on resume
      if (NavigatorManger().isTopPage(this)) {
        onForeground();
        onResume();
      }
    } else if (state == AppLifecycleState.paused) {
      //onpause
      if (NavigatorManger().isTopPage(this)) {
        onBackground();
        onPause();
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    onDestory();
    WidgetsBinding.instance.removeObserver(this);
    _onResumed = false;
    _onPause = false;

    //把改页面 从 页面列表中 去除
    NavigatorManger().removeWidget(this);

    super.dispose();
  }



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
}
