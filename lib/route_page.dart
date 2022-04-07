
import 'package:flutter/material.dart';
import 'package:ja_flutter_demo/widget/clip_page.dart'
deferred as clip_page;
import 'package:ja_flutter_demo/widget/controller_page.dart'
deferred as controller_page;
import 'package:ja_flutter_demo/widget/scroll_listener_page.dart'
deferred as scroll_listener_page;
import 'package:ja_flutter_demo/widget/scroll_to_index_page.dart'
deferred as scroll_to_index_page;


/// 路由中转页面
/// deferred as：延迟加载库
class ContainerAsyncRouterPage extends StatelessWidget {
  final Future libraryFuture;
  final WidgetBuilder child;

  const ContainerAsyncRouterPage(this.libraryFuture,this.child, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // FutureBuilder, 异步构造器
    return FutureBuilder(
      // 待执行的异步任务
        future: libraryFuture,
        // 异步组件构造器
        builder: (context, snapshot) {
          // 异步任务完成
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return RouteErrorPage(snapshot.error);
            }
            return child.call(context);
          }
          return const RouteLoadingPage();
        }
    );
  }
}

/// 路由错误页面
class RouteErrorPage extends StatelessWidget {
  final Object? error;
  const RouteErrorPage(this.error);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        child: Text(
            'Error: $error'
        ),
      ),
    );
  }
}

/// 路由加载页面
class RouteLoadingPage extends StatelessWidget {
  const RouteLoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      ),
    );
  }
}

/// 创建Widget Map集合
Map<String, WidgetBuilder> routers = {
  "文本输入框简单的 Controller": getRouteWidget(controller_page.loadLibrary(), (context) => controller_page.ControllerPage()),
  "实现控件圆角不同组合": getRouteWidget(clip_page.loadLibrary(), (context) => clip_page.ClipPage()),
  "列表滑动监听": getRouteWidget(scroll_listener_page.loadLibrary(), (context) => scroll_listener_page.ScrollListenerPage()),
  "滑动到指定位置": getRouteWidget(scroll_to_index_page.loadLibrary(), (context) => scroll_to_index_page.ScrollToIndexPage()),
};

/// 构建路由WidgetBuilder
/// 参数不能传widget, release 打包时 dart2js 优化会导致时序不对, 报错"flutter deferred library was not loaded"
WidgetBuilder getRouteWidget(Future future, WidgetBuilder widgetBuilder) =>
        (context) => ContainerAsyncRouterPage(future, widgetBuilder);
