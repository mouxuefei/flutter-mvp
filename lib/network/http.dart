//import 'dart:async';
//import 'dart:convert';
//
//import 'package:flutter_mvp/base/BaseWidget.dart';
//import 'package:flutter_mvp/base/BaseNoTitleWidget.dart';
//import 'package:flutter_mvp/config/UrlConstants.dart';
//import 'package:flutter_mvp/model/Article.dart';
//import 'package:flutter_mvp/network/HttpGo.dart';
//import 'package:flutter_mvp/network/api.dart';
//import 'package:flutter_mvp/network/bean/login_response_entity.dart';
//import 'package:flutter_mvp/network/intercept/base_intercept.dart';
//import 'package:rxdart/rxdart.dart';
//
//class RequestMap {
//  static Future requestArticle(BaseIntercept baseIntercept) {
////    Future future = HttpManager().get<Article>(UrlConstants.ARTICLE,
////        baseIntercept: baseIntercept,
////        isCancelable: false).then((data) {
////      return Article.fromJson(json.decode(data));
////    });
////    return future;
//  HttpGo.getInstance().get(UrlConstants.ARTICLE, (data){
//
//  })
//  }
//
//  static Future testErrorrequest(BaseIntercept baseIntercept) {
//    return HttpManager().get<LoginResponseEntity>("error",
//        baseIntercept: baseIntercept);
//  }
//}
