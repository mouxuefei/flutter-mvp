import 'package:flutter_mvp/base/Mvp.dart';
import 'package:flutter_mvp/network/api.dart';

/**
    // ignore: slash_for_doc_comments
 * 这个是一个自定义的 ， 处理 请求前、请求后，对话框的一些配置等自动处理类，只需传入
 */
abstract class BaseIntercept {
  ITopView iTopView;
  bool isDefaultFailure = true;

  void beforeRequest();

  void afterRequest();

  void requestFailure(String desc) {
    //默认请求出错的处理，可以通过设置 isDefaultFailure 来控制
    if (isDefaultFailure) {
      if (iTopView != null && desc != null && desc.isNotEmpty) {
        if (desc.toLowerCase().contains("socketexception") ||
            desc.toLowerCase().contains("connect")) {
          iTopView.toast("网络异常,请检查网络连接");
        } else if (desc.toLowerCase().contains("unknownhostexception")){
          iTopView.toast("网络断开连接");
        }else if(desc.toLowerCase().contains("connecttimeoutexception")){
          iTopView.toast("连接超时");
        }else{
          iTopView.toast(desc);
        }
      }
    }
  }

  String getClassName() {
    return iTopView.className();
  }
}
