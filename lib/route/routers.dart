import 'package:fluro/fluro.dart';
import 'package:flutter_mvp/route/router_handler.dart';

class Routes {
  static String root = "/";
  static String second = "/second";

  static void configureRoutes(Router router) {
//    router.notFoundHandler=Handler()
    router.define(root, handler: homeHandler);
    router.define(second, handler: secondHandler);
  }
}
