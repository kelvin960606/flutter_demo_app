import 'dart:io';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_app/core/application.dart';
import 'package:flutter_demo_app/core/router.dart';
import 'package:flutter_demo_app/pages/index.dart';

class NavigatorUtil {
  /// 退出app
  static outApp(context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: const Text(
                  '确定要退出吗 ?',
                  style: TextStyle(fontSize: 20),
                ),
                actions: <Widget>[
                  ElevatedButton(
                      child: const Text(
                        '退出',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () => exit(0)),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.blue),
                      child: const Text(
                        '取消',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () => Navigator.of(context).pop(false)),
                ]));
  }

  //返回
  static void goBack(BuildContext context) {
    //Navigator.pop(context);
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushNamed(context, Routes.index);
    }
  }

  //带参数返回
  static void goBackWithParams(BuildContext context, result) {
    Navigator.pop(context, result);
  }

  //路由跳转指定页面，带参数
  static void goPage(BuildContext context, String title) {
    return Application.router.pop(context, title);
  }

  // 路由返回指定页面
  static void goBackUrl(BuildContext context, String title) {
    Navigator.popAndPushNamed(context, title);
  }

  // 路由跳转到主页面
  static void goRoot(BuildContext context) {
    Application.router.navigateTo(context, Routes.root,
        replace:
            true); // 如果有给路由赋值就用Routes.root  root是routes文件定义的字符串路径，没有直接用"/"等路由
  }

  // 跳转到转场动画页面
  static Future jump(BuildContext context, String title) {
    return Application.router
        .navigateTo(context, title, transition: TransitionType.inFromRight);
  }

  static Future jumpLeft(BuildContext context, String title) {
    return Application.router
        .navigateTo(context, title, transition: TransitionType.inFromLeft);
  }

  static Future jumpRemove(BuildContext context) {
    return Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const IndexPage(),
        ),
        (route) => route == null);
  }

  /// 使用 IOS 的 Cupertino 的转场动画，这个是修改了源码的 转场动画
  /// /// Fluro本身不带，但是 Flutter自带
  static Future gotransitionCupertinoDemoPage(
      BuildContext context, String title) {
    return Application.router
        .navigateTo(context, title, transition: TransitionType.cupertino);
  }

  /// 跳转到主页面并删除当前路由
  static void goToHomeRemovePage(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const IndexPage(),
        ),
        (route) => route == null);
  }

  ///指把当前页面在栈中的位置替换成跳转的页面（替换导航器的当前路由，通过推送路由[routeName]），当新的页面进入后，之前的页面将执行dispose方法。
  static pushReplacementNamed(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  ///切换无参数页面 Navigator.of(context).pushNamed 直接进入一个新的界面
  static Future pushNamed(BuildContext context, String routeName) {
    return Application.router.navigateTo(context, routeName,
        transition: TransitionType.cupertino,
        routeSettings: RouteSettings(name: routeName),
        //    自定义动画
        transitionDuration: const Duration(milliseconds: 600));
  }

  //切换参数页面 Navigator.of(context).pushNamed
  static Future pushNamedWithParam(
      BuildContext context, String routeName, param) {
    return Application.router.navigateTo(context, routeName,
        transition: TransitionType.cupertino,
        routeSettings: RouteSettings(name: routeName, arguments: param),
        //    自定义动画
        transitionDuration: const Duration(milliseconds: 600));
  }

  /// 指将当前页面pop，然后跳转到制定页面（将当前路由弹出导航器，并将命名路由推到它的位置。）
  static popAndPushNamed(BuildContext context, String routeName) {
    Navigator.maybePop(context).then((v) {
      pushNamed(context, routeName);
    });
  }

  /// 指将当前页面pop，然后跳转到制定页面（将当前路由弹出导航器，并将命名路由推到它的位置。）
  static popAndPushNamedWithParam(
      BuildContext context, String routeName, param) {
    Navigator.maybePop(context).then((v) {
      pushNamedWithParam(context, routeName, param);
    });
  }

  /// 指将制定的页面加入到路由中，然后将其他所有的页面全部pop, (Route<dynamic> route) => false将确保删除推送路线之前的所有路线。
  static pushNamedAndRemoveUntil(BuildContext context, String routeName) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false);
  }

  /// 指将制定的页面加入到路由中
  static pushNamedAndRemoveUntilThat(
      BuildContext context, String routeName, String untilRName) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(routeName, ModalRoute.withName(untilRName));
  }

  /// 指将制定的页面加入到路由中
  static pushNamedAndRemoveUntilThatParam(
      BuildContext context, String routeName, String untilRName, param) {
    Navigator.of(context).pushNamedAndRemoveUntil(
        routeName, ModalRoute.withName(untilRName),
        arguments: param);
  }

  /// maybePop 会自动进行判断，如果当前页面pop后，会显示其他页面，不会出现问题，则将执行当前页面的pop操作
  static maybePop(BuildContext context) {
    Navigator.of(context).maybePop();
  }

  ///Page页面的容器，做一次通用自定义
  static Widget pageContainer(widget, BuildContext context) {
    return MediaQuery(

        ///不受系统字体缩放影响
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
        child: widget);
  }
}
