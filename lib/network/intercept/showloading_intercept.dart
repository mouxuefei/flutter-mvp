import 'package:flutter_mvp/base/Mvp.dart';
import 'package:flutter_mvp/network/intercept/base_intercept.dart';

 class ShowLoadingIntercept extends BaseIntercept {
  ShowLoadingIntercept(ITopView iTopView,
      {bool isDefaultFailure = true}) {
    this.iTopView = iTopView;
    this.isDefaultFailure = isDefaultFailure;
  }
  @override
  void afterRequest() {
    if (iTopView != null) {
      iTopView.dismissLoading();
    }
  }

  @override
  void beforeRequest() {
    if (iTopView != null) {
      iTopView.showLoading("加载中...");
    }
  }
}
