# flutter_mvp



## 项目介绍

 该项目为flutter的mvp的基础架构,主要封装了mvp基础类,使用dio进行网络框架封装,使用fluro进行路由跳转;



* mvp使用

思想和我封装android的mvp的思想基本一致,但是由于dart和kotlin的语法差别,可能有些地方还是不太一样,如果想了解我原生的mvp封装可以参考文章[https://blog.csdn.net/villa_mou/article/details/81185903](https://blog.csdn.net/villa_mou/article/details/81185903)
	
> contract

	abstract class SecondView extends IView<SecondPresenter>{
      	void showSucc(Article article);
    }
    
    abstract class SecondPresenter  extends IPresenter<SecondView>{
      Future loadContacts();
    }

> presenter
 
	class SecondPresenterImp extends BasePresenterKt<SecondView>
    implements SecondPresenter {

  	@override
  	Future loadContacts() async {
   
  	}
	}

> view

	class SecondWidget extends BaseMvpWidget {
  	 String name;
  	 String title;
  	 SecondWidget(this.name,this.title);
  	 @override
  	 BaseMvpWidgetState<ITopPresenter, BaseMvpWidget> getMvpState() {
    	return SecondPage(name,title);
  	 }
	 }

    class SecondPage extends BaseMvpWidgetState<SecondPresenter, SecondWidget>
    implements SecondView {
      String name;
      String title;
      SecondPage(this.name,this.title);
    
      @override
      SecondPresenter mPresenter = SecondPresenterImp();
    
      @override
      void initData() {
    	mPresenter.loadContacts();
      }
    
      @override
      void showSucc(Article article) {
    	toast(article.data[0].name);
      }
    
      @override
      void initView() {
     
    
      }
    
      @override
      Widget buildWidget(BuildContext context) {
    var widget = new ListView(
    padding: new EdgeInsets.symmetric(vertical: 8.0),
    children: [
      Text("aaaaaaaaaaaaaaa"),
      Text("传递过来的参数{$name$title}"),
    ]
    );
    return widget;
      }
    
    }

 * 网络框架的使用

网络框架使用dio,这个玩意有页面销毁的时候取消网络请求的cancelToken,比较符合之前原生开发的业务场景,具体使用

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

ShowLoadingIntercept(mView)为是否显示loading弹窗,loading弹窗封装在基类的,也就是原生的baseActivity,通过ItopView进行调用的,并且基类封装了空布局,错误布局,loading布局,只需要在presenter中通过mview调用即可;
这里基类的封装参考了另外一个项目

 * fluro路由的使用

fluro简化了Flutter的路由开发，也是目前Flutter生态中最成熟的路由框架。

首先需要配置路由路径
    
    class Routes {
  	 static String root = "/";
  	 static String second = "/second";

  	static void configureRoutes(Router router) {
		//router.notFoundHandler=Handler()
    	router.define(root, handler: homeHandler);
    	router.define(second, handler: secondHandler);
  	 }
	}


然后配置handler(带参和不带参)

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

最后路由跳转

      String route = '/second?name=${Uri.encodeComponent("张三")}&title=${Uri.encodeComponent("你好")}';
      Application.router.navigateTo(context, route,transition: TransitionType.fadeIn);

## 最后
鄙人能力有限,暂时只能封装成这样,如果有小伙伴有好的建议,欢迎一起分享讨论;

参考项目:

1,[https://github.com/385841539/flutter_BaseWidget](https://github.com/385841539/flutter_BaseWidget)

2,[https://github.com/yzxzm/flutter_ydd](https://github.com/yzxzm/flutter_ydd)
