import 'package:flutter_mvp/base/Mvp.dart';
import 'package:flutter_mvp/network/intercept/base_intercept.dart';

class NoActionIntercept extends BaseIntercept {
  NoActionIntercept(ITopView iTopView, {bool isDefaultFailure = true}) {
    this.iTopView = iTopView;
    this.isDefaultFailure = isDefaultFailure;
  }
  @override
  void afterRequest() {}

  @override
  void beforeRequest() {}
}
