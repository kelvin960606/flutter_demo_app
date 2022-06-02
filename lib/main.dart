import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo_app/pages/splash.dart';
import 'package:flutter_demo_app/providers/index.dart';
import 'package:flutter_demo_app/services/init_service.dart';
import 'package:flutter_demo_app/services/storage_manager.dart';
import 'package:flutter_demo_app/translations/index.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:json_theme/json_theme.dart';
import 'package:provider/provider.dart';

import 'core/application.dart';
import 'core/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final router = FluroRouter();
  Routes.configureRoutes(router);
  Application.router = router;
  await StorageManger.initHive();
  InitializeService.init();
  // slow processing  more 5 second...
  final themeStr =
      await rootBundle.loadString('lib/assets/appainter_theme.json');
  final darkthemeStr =
      await rootBundle.loadString('lib/assets/appainter_theme_dark.json');
  final themeJson = jsonDecode(themeStr);
  final darkThemeJson = jsonDecode(darkthemeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;
  final darkTheme = ThemeDecoder.decodeThemeData(darkThemeJson)!;

  runApp(MyApp(
    theme: theme,
    darkTheme: darkTheme,
  ));
}

class MyApp extends StatelessWidget {
  final ThemeData theme;
  final ThemeData darkTheme;

  const MyApp({Key? key, required this.theme, required this.darkTheme})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        darkTheme: darkTheme,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'US'), // English
          Locale('zh', 'CN'), // 中文简体
        ],
        locale: const Locale('en', 'US'), // 设置默认语言
        translations: Messages(), // 翻译
        fallbackLocale: const Locale('en', 'US'), // 在配置错误的情况下使用的语言
        localeResolutionCallback:
            (Locale? locale, Iterable<Locale> supportedLocales) {
          return locale;
        },

        onGenerateRoute: Application.router.generator,
        home: const SplashPage(),
        builder: (context, child) {
          ScreenUtil.init(
            context,
            minTextAdapt: true,
            designSize: const Size(375, 720),
          );
          child = Scaffold(
            resizeToAvoidBottomInset: false,
            body: GestureDetector(
              onTap: () => hideKeyboard(context),
              child: child,
            ),
          );
          return child;
        },
      ),
    );
  }

  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }
}
