import 'package:flutter_mvp/base/Mvp.dart';
import 'package:flutter_mvp/base/BaseWidget.dart';
import 'package:flutter_mvp/network/HttpGo.dart';
import 'package:flutter_mvp/network/api.dart';

 abstract class BaseMvpWidget extends BaseWidget {
  BaseMvpWidgetState baseMvpWidgetState;

  BaseMvpWidgetState getMvpState();

  @override
  BaseWidgetState<BaseWidget> getState() {
    baseMvpWidgetState = getMvpState();
    return baseMvpWidgetState;
  }

}

abstract class BaseMvpWidgetState< P extends ITopPresenter,T extends BaseMvpWidget>
    extends BaseWidgetState<T>
    implements IView<P> {

   @override
  void initState() {
    super.initState();
    mPresenter.attachView(this);
    initData();
  }


  void initData();

  @override
  void dispose() {
    super.dispose();
    HttpGo.cancelHttp(className());
  }
}




