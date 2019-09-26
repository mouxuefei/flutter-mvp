//import 'dart:async';
//import 'dart:convert';
//import 'dart:io';
//
//import 'package:dio/dio.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_mvp/base/BuildConfig.dart';
//import 'package:flutter_mvp/config/UrlConstants.dart';
//import 'package:flutter_mvp/model/BaseModel.dart';
//import 'package:flutter_mvp/network/intercept/HeaderIntercept.dart';
//import 'package:flutter_mvp/network/intercept/base_intercept.dart';
//import 'package:flutter_mvp/utils/entity_factory.dart';
//import 'package:fluttertoast/fluttertoast.dart';
//import 'package:rxdart/rxdart.dart';
//
/////http请求
//class HttpManager {
//  static const CONTENT_TYPE_JSON = "application/json";
//  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";
//  static Dio _dio;
//  static final int CONNECR_TIME_OUT = 5000;
//  static final int RECIVE_TIME_OUT = 3000;
//  static Map<String, CancelToken> _cancelTokens =
//  new Map<String, CancelToken>();
//
//  HttpManager._internal() {
//    initDio();
//  }
//
//  static HttpManager _httpManger = HttpManager._internal();
//
//  factory HttpManager() {
//    return _httpManger;
//  }
//
//  //get请求
//  Future<T> get<T>(String url, {
//    Map<String, dynamic> queryParameters,
//    BaseIntercept baseIntercept,
//    bool isCancelable = true,
//  }) {
//    return _requstHttp<T>(
//        url, true, queryParameters, baseIntercept, isCancelable);
//  }
//
//  //post请求
//  Future<T> post<T>(String url,
//      {Map<String, dynamic> queryParameters,
//        BaseIntercept baseIntercept,
//        bool isCancelable = true,
//        bool isSHowErrorToast = true}) {
//    return _requstHttp<T>(url, false, FormData.from(queryParameters),
//        baseIntercept, isCancelable);
//  }
//
//  /// 参数说明  url 请求路径
//  /// queryParamerers  是 请求参数
//  /// baseWidget和baseInnerWidgetState用于 加载loading 和 设置 取消CanselToken
//  /// isCancelable 是设置改请求是否 能被取消 ， 必须建立在 传入baseWidget或者baseInnerWidgetState的基础之上
//  /// isShowLoading 设置是否能显示 加载loading , 同样要建立在传入 baseWidget或者 baseInnerWidgetState 基础之上
//  /// isShowErrorToaet  这个是 设置请求失败后 是否要 吐司的
//  Future<T> _requstHttp<T>(String url,
//      [bool isGet,
//        queryParameters,
//        BaseIntercept baseIntercept,
//        bool isCancelable]) async {
////    PublishSubject<T> publishSubject = PublishSubject<T>();
//
//    CancelToken cancelToken;
//
//    //设置取消请求的token
//    _setInterceptOrcancelAble(baseIntercept, isCancelable, cancelToken);
//
//    var future;
//    if (isGet) {
//      future = await _dio.get(url,
//          queryParameters: queryParameters, cancelToken: cancelToken);
//    } else {
//      future =await  _dio.post(url, data: queryParameters, cancelToken: cancelToken);
//    }
//    future.then((data) {
//      print(data);
//      var baseModel = json.decode(data.toString());
//      if (baseModel['errorCode'] == 0) {
//        cancelLoading(baseIntercept);
//      } else {
//        callError(
//          MyError(10, "请求失败~"),
//          baseIntercept,
//        );
//      }
//    }).catchError((err) {
//      callError(MyError(1, err.toString()), baseIntercept);
//    });
//  return future;
//  }
//
//  ///请求错误以后 做的一些事情
//  void callError(MyError error,
//      BaseIntercept baseIntercept) {
//    cancelLoading(baseIntercept);
//    if (baseIntercept != null) {
//      baseIntercept.requestFailure(error.message);
//    }
//  }
//
//  ///取消请求
//  static void cancelHttp(String tag) {
//    if (_cancelTokens.containsKey(tag)) {
//      if (!_cancelTokens[tag].isCancelled) {
//        _cancelTokens[tag].cancel();
//      }
//      _cancelTokens.remove(tag);
//    }
//  }
//
//  ///配置dio
//  void initDio() {
//    _dio = Dio();
//    _dio.options.baseUrl = UrlConstants.BASE_URL;
//    _dio.options.connectTimeout = CONNECR_TIME_OUT;
//    _dio.options.receiveTimeout = RECIVE_TIME_OUT;
//    _dio.options.contentType = ContentType.parse(CONTENT_TYPE_FORM);
//    //添加请求头
//    _dio.interceptors.add(new HeaderIntercept());
//  }
//
//  ///测试是否真的 可以清除 的方法
//  static void listCancelTokens() {
//    _cancelTokens.forEach((key, value) {
//      print("${key}-----cancel---");
//    });
//  }
//
//  //配置是否 显示 loading 和 是否能被取消
//  void _setInterceptOrcancelAble(BaseIntercept baseIntercept, bool isCancelable,
//      CancelToken cancelToken) {
//    if (baseIntercept != null) {
//      baseIntercept.beforeRequest();
//      //为了 能够取消 请求
//      if (isCancelable) {
//        cancelToken = _cancelTokens[baseIntercept.getClassName()] == null
//            ? CancelToken()
//            : _cancelTokens[baseIntercept.getClassName()];
//        _cancelTokens[baseIntercept.getClassName()] = cancelToken;
//      }
//    }
//  }
//
//  void showErrorToast(String message) {
//    //TODO 统一错误提示
//    showToast(message);
//  }
//
//  void showToast(String content,
//      {Toast length = Toast.LENGTH_SHORT,
//        ToastGravity gravity = ToastGravity.BOTTOM,
//        Color backColor = Colors.black54,
//        Color textColor = Colors.white}) {
//    if (content != null) {
//      Fluttertoast.showToast(
//          msg: content,
//          toastLength: length,
//          gravity: gravity,
//          timeInSecForIos: 1,
//          backgroundColor: backColor,
//          textColor: textColor,
//          fontSize: 13.0);
//    }
//  }
//
//  void cancelLoading(BaseIntercept baseIntercept) {
//    if (baseIntercept != null) {
//      baseIntercept.afterRequest();
//    }
//  }
//}
//
//class MyError {
//  int code;
//  String message;
//
//  MyError(this.code, this.message);
//}
