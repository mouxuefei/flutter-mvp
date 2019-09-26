import 'package:flutter_mvp/base/Mvp.dart';
import 'package:flutter_mvp/model/Article.dart';

abstract class SecondView extends IView<SecondPresenter>{
  void showSucc(Article article);
}

abstract class SecondPresenter  extends IPresenter<SecondView>{
  Future loadContacts();
}


