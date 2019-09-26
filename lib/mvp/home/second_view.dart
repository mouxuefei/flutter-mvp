import 'package:flutter/material.dart';
import 'package:flutter_mvp/base/BaseMvpWidget.dart';
import 'package:flutter_mvp/base/BaseWidget.dart';
import 'package:flutter_mvp/base/Mvp.dart';
import 'package:flutter_mvp/model/Article.dart';
import 'package:flutter_mvp/mvp/home/second_contract.dart';
import 'package:flutter_mvp/mvp/home/second_presenter.dart';

class SecondWidget extends BaseMvpWidget {
  String name;
  String title;
  SecondWidget(this.name,this.title);
  @override
  BaseMvpWidgetState<ITopPresenter, BaseMvpWidget> getMvpState() {
    return SecondPage(name,title);
  }
}

class SecondPage extends BaseMvpWidgetState<SecondPresenter, SecondWidget>
    implements SecondView {
  String name;
  String title;
  SecondPage(this.name,this.title);

  @override
  SecondPresenter mPresenter = SecondPresenterImp();

  @override
  void initData() {
    mPresenter.loadContacts();
  }

  @override
  void showSucc(Article article) {
    toast(article.data[0].name);
  }

  @override
  void initView() {
  setAppBarTitle("aaaa");
  setAppBarRightTitle("bbbb");


  }

  @override
  Widget buildWidget(BuildContext context) {
    var widget = new ListView(
        padding: new EdgeInsets.symmetric(vertical: 8.0),
        children: [
          Text("aaaaaaaaaaaaaaa"),
          Text("传递过来的参数{$name$title}"),
        ]
    );
    return widget;
  }

}
