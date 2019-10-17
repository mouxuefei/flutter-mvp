import 'package:flutter_mvp/base/BaseMvpPresenter.dart';
import 'package:flutter_mvp/config/UrlConstants.dart';
import 'package:flutter_mvp/model/Article.dart';
import 'package:flutter_mvp/mvp/home/second_contract.dart';
import 'package:flutter_mvp/network/HttpGo.dart';
import 'package:flutter_mvp/network/http.dart';
import 'package:flutter_mvp/network/intercept/showloading_intercept.dart';

class SecondPresenterImp extends BasePresenterKt<SecondView>
    implements SecondPresenter {

  @override
  Future loadContacts() async {
    HttpGo.getInstance()
        .get(UrlConstants.ARTICLE
        , ShowLoadingIntercept(mView)
        , (data) {
          var article =Article.fromJson(data);
          mView.showSucc(article);
        }
        , errorCallBack: () {
            mView.setErrorWidgetVisible(true);
        });
  }


}
