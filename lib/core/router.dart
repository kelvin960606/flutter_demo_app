// 这个页面是设置路由跳转衔接模块

import 'package:fluro/fluro.dart';
import './router_handler.dart';

class Routes {
  //配置类

//  这边是配置路由
  static String root = '/'; //根目录
  static String index = "/index";
  static String homepage = "/home";
  static String loginpage = "/login";
  static String settingpage = "/setting";

  //静态方法
  static void configureRoutes(FluroRouter router) {
    //路由配置
    //找不到路由
    router.notFoundHandler = emptyPageHanderl;
    //整体配置--对应路由的页面  handler的值是跳转另一个页面后要处理的内容
    router.define(root, handler: splashPageHanderl);
    router.define(index, handler: indexPageHanderl);
    router.define(homepage, handler: homepageHandlerl);
    router.define(loginpage, handler: loginpageHandlerl);
    router.define(settingpage, handler: settingpageHandlerl);
  }
}
