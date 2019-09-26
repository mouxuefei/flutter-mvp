import 'package:flutter/material.dart';
import 'package:flutter_mvp/base/BaseWidget.dart';
import 'package:flutter_mvp/base/BaseNoTitleWidget.dart';
import 'package:flutter_mvp/mvp/tab/firstPage.dart';
import 'package:flutter_mvp/widgets/GSYTabBarWidget.dart';
import 'package:flutter_mvp/mvp/tab/secondPage.dart';
import 'package:flutter_mvp/mvp/tab/thirdPage.dart';

class HomeTabWidget extends BaseWidget {
  @override
  BaseWidgetState<BaseWidget> getState() {
    return _HomeTabPage();
  }
}

class _HomeTabPage extends BaseWidgetState<HomeTabWidget>
    with SingleTickerProviderStateMixin {
  TabController tabcontroller;
  List<Widget> pages;
  List<Tab> tabs;

  @override
  void initView() {
    setBackIconHinde();
    tabcontroller = new TabController(
        length: 3, //Tab页的个数
        vsync: this //动画效果的异步处理，默认格式
    );
    pages = [FirstInnerPage(), SecondInnerPage(), ThirdInnerPage()];
    tabs = [
      Tab(child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>
        [
          Icon(Icons.home, size: 25.0),
          Text("主页", style: TextStyle(fontSize: 12))
        ],
      ),
      ),
      Tab(child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[Icon(Icons.accessibility, size: 25.0), Text("权限"),],
      ),
      ),
      Tab(child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[Icon(Icons.person, size: 25.0), Text("个人中心")],),
      ),
    ];
  }


  @override
  Widget buildWidget(BuildContext context) {
    return new Scaffold(
        body: new TabBarView(
          controller: tabcontroller,
          children: pages,
        ),
        bottomNavigationBar:
          new Container(
            height: 55,
            //decoration和color不能同时用
            decoration: BoxDecoration(color: Colors.white, boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey[300],
              ),
            ]
            ),
            //底部栏整体的颜色
            child: new TabBar(
              controller: tabcontroller,
              tabs: tabs,
              labelColor: Colors.amber,
              unselectedLabelColor: Colors.black,
              indicatorColor: Colors.white,
            ),
        )
    );
  }

  @override
  void dispose() {
    //释放内存，节省开销
    tabcontroller.dispose();
    super.dispose();
  }
}
