import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvp/route/router_application.dart';
import 'package:flutter_mvp/route/routers.dart';
import 'package:flutter_mvp/mvp/tab/home_page.dart';
import 'package:flutter_mvp/utils/sp_utils/sp_utils.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  MyApp() {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    SpUtils().init(); //初始化 sp
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
