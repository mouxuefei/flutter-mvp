import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvp/config/UrlConstants.dart';
import 'package:flutter_mvp/network/api.dart';
import 'package:flutter_mvp/network/intercept/HeaderIntercept.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'intercept/base_intercept.dart';

class HttpGo {
  static final String GET = "get";
  static final String POST = "post";
  static final String DATA = "data";
  static final String CODE = "errorCode";
  static final int CONNECR_TIME_OUT = 5000;
  static final int RECIVE_TIME_OUT = 3000;
  static Map<String, CancelToken> _cancelTokens = Map<String, CancelToken>();
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";

  Dio dio;
  static HttpGo _instance;

  static HttpGo getInstance() {
    if (_instance == null) {
      _instance = HttpGo();
    }
    return _instance;
  }

  HttpGo() {
    dio = Dio();
    dio.options.baseUrl = UrlConstants.BASE_URL;
    dio.options.connectTimeout = CONNECR_TIME_OUT;
    dio.options.receiveTimeout = RECIVE_TIME_OUT;
    dio.options.contentType = ContentType.parse(CONTENT_TYPE_FORM);
    //添加请求头
    dio.interceptors.add(new HeaderIntercept());
  }

  //get请求
  get(String url, BaseIntercept baseIntercept, Function successCallBack,
      {Map<String,
          dynamic> params, bool isCancelable = true, Function errorCallBack}) async {
    _requstHttp(
        url,
        successCallBack,
        GET,
        params,
        baseIntercept,
        isCancelable,
        errorCallBack);
  }

  //post请求
  post(String url, BaseIntercept baseIntercept, Function successCallBack,
      {params, bool isCancelable = true, Function errorCallBack}) async {
    _requstHttp(
        url,
        successCallBack,
        POST,
        FormData.from(params),
        baseIntercept,
        isCancelable,
        errorCallBack);
  }

  _requstHttp(String url, Function successCallBack,
      [String method, params, BaseIntercept baseIntercept, bool isCancelable, Function errorCallBack]) async {
    String errorMsg = '';
    int code;
    CancelToken cancelToken;
    //设置取消请求的token
    _setInterceptOrcancelAble(baseIntercept, isCancelable, cancelToken);
    try {
      Response response;
      if (method == GET) {
        if (params != null && params.isNotEmpty) {
          response = await dio.get(url, queryParameters: params);
        } else {
          response = await dio.get(url);
        }
      } else if (method == POST) {
        if (params != null && params.isNotEmpty) {
          response = await dio.post(url, data: params);
        } else {
          response = await dio.post(url);
        }
      }
      code = response.statusCode;
      if (code != 200) {
        errorMsg = '错误码：' + code.toString() + '，' + response.data.toString();
        callError(errorCallBack,errorMsg, baseIntercept);
        return;
      }
      String dataStr = json.encode(response.data);
      print(dataStr);
      Map<String, dynamic> dataMap = json.decode(dataStr);
      if (dataMap != null && dataMap[CODE] == 0) {
        cancelLoading(baseIntercept);
        if (successCallBack != null) {
          successCallBack(response.data);
        }
      } else {
        errorMsg = response.data.toString();
        callError(errorCallBack, response.data.toString(), baseIntercept);
      }
    } catch (exception) {
      callError(errorCallBack,exception.toString(), baseIntercept);
    }
  }

  ///请求错误以后 做的一些事情
  void callError(Function errorCallBack,String error,
      BaseIntercept baseIntercept) {
    cancelLoading(baseIntercept);
    if(errorCallBack!=null){
      errorCallBack();
    }
    if (baseIntercept != null) {
      baseIntercept.requestFailure(error);
    }
  }

  void showToast(String content,
      {Toast length = Toast.LENGTH_SHORT,
        ToastGravity gravity = ToastGravity.BOTTOM,
        Color backColor = Colors.black54,
        Color textColor = Colors.white}) {
    if (content != null) {
      Fluttertoast.showToast(
          msg: content,
          toastLength: length,
          gravity: gravity,
          timeInSecForIos: 1,
          backgroundColor: backColor,
          textColor: textColor,
          fontSize: 13.0);
    }
  }

  void cancelLoading(BaseIntercept baseIntercept) {
    if (baseIntercept != null) {
      baseIntercept.afterRequest();
    }
  }

  //配置是否 显示 loading 和 是否能被取消
  void _setInterceptOrcancelAble(BaseIntercept baseIntercept, bool isCancelable,
      CancelToken cancelToken) {
    if (baseIntercept != null) {
      baseIntercept.beforeRequest();
      //为了 能够取消 请求
      if (isCancelable) {
        cancelToken = _cancelTokens[baseIntercept.getClassName()] == null
            ? CancelToken()
            : _cancelTokens[baseIntercept.getClassName()];
        _cancelTokens[baseIntercept.getClassName()] = cancelToken;
      }
    }
  }

  ///取消请求
  static void cancelHttp(String tag) {
    if (_cancelTokens.containsKey(tag)) {
      if (!_cancelTokens[tag].isCancelled) {
        _cancelTokens[tag].cancel();
      }
      _cancelTokens.remove(tag);
    }
  }
}

