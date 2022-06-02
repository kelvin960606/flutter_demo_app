// 这个页面是设置穿什么参数等

import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_demo_app/pages/home.dart';
import 'package:flutter_demo_app/pages/index.dart';
import 'package:flutter_demo_app/pages/login.dart';
import 'package:flutter_demo_app/pages/settings.dart';
import 'package:flutter_demo_app/pages/splash.dart';

Handler emptyPageHanderl = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const Scaffold(
    body: Center(
      child: Text('404 Not Found'),
    ),
  );
});

Handler indexPageHanderl = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const IndexPage();
});

Handler splashPageHanderl = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const SplashPage();
});

Handler loginpageHandlerl = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return LoginPage();
});

Handler homepageHandlerl = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const HomePage(
    username: '',
  );
});
Handler settingpageHandlerl = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const SettingPage();
});
