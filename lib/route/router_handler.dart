import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mvp/mvp/home/second_view.dart';
import 'package:flutter_mvp/mvp/tab/home_page.dart';

var homeHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return HomeTabWidget();
});

var secondHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
      String name = parameters["name"].first;
      String title = parameters["title"].first;
      return new SecondWidget(name, title);
    });
