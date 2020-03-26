import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter_mvp/route/router_application.dart';
import 'package:flutter_mvp/route/routers.dart';
import 'package:flutter_mvp/mvp/tab/home_page.dart';
import 'package:flutter_mvp/simple.dart';
import 'package:flutter_mvp/utils/sp_utils/sp_utils.dart';

import 'mvp/tab/firstPage.dart';
import 'mvp/tab/secondPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  MyApp() {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
    SpUtils().init(); //初始化 sp
  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      onGenerateRoute: Application.router.generator,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeTabWidget(),
    );
  }
}

//class MyApp extends StatefulWidget {
//  @override
//  _MyAppState createState() => _MyAppState();
//}

//class _MyAppState extends State<MyApp> {
//  @override
//  void initState() {
//    super.initState();
//
//    FlutterBoost.singleton.registerPageBuilders({
//      'embeded': (pageName, params, _) => EmbededFirstRouteWidget(),
//      'first': (pageName, params, _) {
//        print("flutterPage params:$params");
//        return FirstRouteWidget();
//      },
//      'second': (pageName, params, _) => SecondRouteWidget(),
//      'tab': (pageName, params, _) => TabRouteWidget(),
//      'platformView': (pageName, params, _) => PlatformRouteWidget(),
//      'flutterFragment': (pageName, params, _) => FragmentRouteWidget(params),
//      'flutterPage': (pageName, params, _) {
//        print("flutterPage params:$params");
//        return FlutterRouteWidget(params: params);
//      },
//    });
//    FlutterBoost.singleton.addBoostNavigatorObserver(
//        TestBoostNavigatorObserver());
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//        title: 'Flutter Boost example',
//        builder: FlutterBoost.init(postPush: _onRoutePushed),
//        home: Container(
//            color: Colors.white
//        ));
//  }
//
//  void _onRoutePushed(String pageName, String uniqueId, Map params, Route route,
//      Future _) {
//  }
//}
//
//class TestBoostNavigatorObserver extends NavigatorObserver {
//  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
//    print("flutterboost#didPush");
//  }
//
//  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
//    print("flutterboost#didPop");
//  }
//
//  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {
//    print("flutterboost#didRemove");
//  }
//
//  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
//    print("flutterboost#didReplace");
//  }
//}